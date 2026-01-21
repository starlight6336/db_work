package com.example.mybatisplus.service;

import com.example.mybatisplus.model.domain.ev.*;
import com.example.mybatisplus.model.domain.ev.enums.OrderStatus;
import com.example.mybatisplus.model.domain.ev.enums.PromotionStatus;
import com.example.mybatisplus.model.domain.ev.enums.TestDriveStatus;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;

import javax.annotation.PostConstruct;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArrayList;
import java.util.concurrent.atomic.AtomicLong;
import java.util.stream.Collectors;

@Service
public class EvSaleService {

    private final Map<Long, Vehicle> vehicles = new ConcurrentHashMap<>();
    private final Map<Long, Promotion> promotions = new ConcurrentHashMap<>();
    private final Map<Long, OrderRecord> orders = new ConcurrentHashMap<>();
    private final Map<Long, ReviewRecord> reviews = new ConcurrentHashMap<>();
    private final Map<Long, TestDriveRecord> testDrives = new ConcurrentHashMap<>();
    private final Map<Long, UserProfile> users = new ConcurrentHashMap<>();
    private final Map<Long, FinancialPlan> financialPlans = new ConcurrentHashMap<>();
    private final Map<Long, List<Long>> inventorySubscriptions = new ConcurrentHashMap<>();
    private final Map<Long, List<Long>> browseHistory = new ConcurrentHashMap<>();

    private final AtomicLong idGenerator = new AtomicLong(1000);
    private final AtomicLong orderNoGenerator = new AtomicLong(20240000);

    @PostConstruct
    public void seed() {
        if (!vehicles.isEmpty()) {
            return;
        }
        UserProfile admin = new UserProfile();
        admin.setId(1L);
        admin.setName("管理员");
        admin.setPhone("13800000000");
        admin.setAddress("总部门店");
        admin.setRegisterTime(LocalDateTime.now().minusDays(30));
        users.put(admin.getId(), admin);

        UserProfile alice = new UserProfile();
        alice.setId(2L);
        alice.setName("Alice");
        alice.setPhone("13900000001");
        alice.setAddress("上海虹桥提车中心");
        alice.setRegisterTime(LocalDateTime.now().minusDays(12));
        alice.getPreferBrands().addAll(Arrays.asList("蔚来", "比亚迪"));
        alice.getPreferBatteryTypes().add("三元锂");
        users.put(alice.getId(), alice);

        Vehicle et5 = new Vehicle();
        et5.setName("蔚来 ET5");
        et5.setBrand("蔚来");
        et5.setRangeKm(560);
        et5.setBatteryType("三元锂");
        et5.setGuidePrice(new BigDecimal("328000"));
        et5.setStock(8);
        et5.setLaunchDate(LocalDate.now().minusMonths(7));
        et5.setFastChargeMinutes(35);
        et5.setSmartDriveLevel("L2+");
        et5.getConfigs().put("驱动形式", "双电机四驱");
        et5.getConfigs().put("零百加速", "4.0s");
        saveVehicle(et5);

        Vehicle seal = new Vehicle();
        seal.setName("比亚迪 海豹");
        seal.setBrand("比亚迪");
        seal.setRangeKm(650);
        seal.setBatteryType("磷酸铁锂");
        seal.setGuidePrice(new BigDecimal("228000"));
        seal.setStock(3);
        seal.setLaunchDate(LocalDate.now().minusMonths(10));
        seal.setFastChargeMinutes(28);
        seal.setSmartDriveLevel("L2");
        seal.getConfigs().put("驱动形式", "后驱");
        seal.getConfigs().put("零百加速", "5.9s");
        saveVehicle(seal);

        Vehicle modelY = new Vehicle();
        modelY.setName("特斯拉 Model Y");
        modelY.setBrand("特斯拉");
        modelY.setRangeKm(545);
        modelY.setBatteryType("三元锂");
        modelY.setGuidePrice(new BigDecimal("261900"));
        modelY.setStock(12);
        modelY.setLaunchDate(LocalDate.now().minusYears(1));
        modelY.setFastChargeMinutes(25);
        modelY.setSmartDriveLevel("L2");
        modelY.getConfigs().put("驱动形式", "双电机四驱");
        modelY.getConfigs().put("零百加速", "5.0s");
        saveVehicle(modelY);

        Promotion sealPromotion = new Promotion();
        sealPromotion.setVehicleId(seal.getId());
        sealPromotion.setTitle("海豹春季折扣");
        sealPromotion.setType("车型折扣");
        sealPromotion.setDescription("限时 9 折并赠送家用充电桩");
        sealPromotion.setDiscountRate(new BigDecimal("0.90"));
        sealPromotion.setGift("家用充电桩");
        sealPromotion.setStartDate(LocalDate.now().minusDays(10));
        sealPromotion.setEndDate(LocalDate.now().plusDays(20));
        savePromotion(sealPromotion);

        FinancialPlan plan = new FinancialPlan();
        plan.setVehicleId(modelY.getId());
        plan.setName("轻享金融 20% 首付");
        plan.setDownPaymentRate(new BigDecimal("0.20"));
        plan.setMonths(36);
        plan.setAnnualRate(new BigDecimal("0.038"));
        saveFinancialPlan(plan);

        OrderRecord sampleOrder = new OrderRecord();
        sampleOrder.setUserId(alice.getId());
        sampleOrder.setVehicleId(seal.getId());
        sampleOrder.setQuantity(1);
        sampleOrder.setStore("上海浦东店");
        sampleOrder.setContactName("Alice");
        sampleOrder.setContactPhone("13900000001");
        sampleOrder.setCreatedAt(LocalDateTime.now().minusDays(5));
        OrderRecord created = createOrder(sampleOrder);
        if (created != null && created.getId() != null) {
            markPaid(created.getId());
        }
    }

    private Long nextId() {
        return idGenerator.incrementAndGet();
    }

    public synchronized Vehicle saveVehicle(Vehicle vehicle) {
        if (vehicle.getId() == null) {
            vehicle.setId(nextId());
        }
        vehicles.put(vehicle.getId(), vehicle);
        return vehicle;
    }

    public synchronized Vehicle updateVehicle(Long id, Vehicle payload) {
        Vehicle exist = vehicles.get(id);
        if (exist == null) {
            throw new IllegalArgumentException("车辆不存在");
        }
        payload.setId(id);
        vehicles.put(id, payload);
        return payload;
    }

    public synchronized void deleteVehicle(Long id) {
        vehicles.remove(id);
        promotions.values().removeIf(p -> Objects.equals(p.getVehicleId(), id));
    }

    public List<Vehicle> listVehicles(String brand, BigDecimal minPrice, BigDecimal maxPrice,
                                      Integer minRange, Integer maxRange, String batteryType,
                                      String sortBy, String order) {
        Comparator<Vehicle> comparator = Comparator.comparing(Vehicle::getId);
        if ("price".equalsIgnoreCase(sortBy)) {
            comparator = Comparator.comparing(Vehicle::getGuidePrice);
        } else if ("range".equalsIgnoreCase(sortBy)) {
            comparator = Comparator.comparing(Vehicle::getRangeKm);
        }
        if ("desc".equalsIgnoreCase(order)) {
            comparator = comparator.reversed();
        }
        return vehicles.values().stream()
                .filter(v -> !StringUtils.hasText(brand) || brand.equalsIgnoreCase(v.getBrand()))
                .filter(v -> minPrice == null || v.getGuidePrice().compareTo(minPrice) >= 0)
                .filter(v -> maxPrice == null || v.getGuidePrice().compareTo(maxPrice) <= 0)
                .filter(v -> minRange == null || v.getRangeKm() >= minRange)
                .filter(v -> maxRange == null || v.getRangeKm() <= maxRange)
                .filter(v -> !StringUtils.hasText(batteryType) || batteryType.equalsIgnoreCase(v.getBatteryType()))
                .sorted(comparator)
                .collect(Collectors.toList());
    }

    public VehicleDetail getVehicleDetail(Long vehicleId) {
        Vehicle vehicle = vehicles.get(vehicleId);
        if (vehicle == null) {
            throw new IllegalArgumentException("车辆不存在");
        }
        VehicleDetail detail = new VehicleDetail();
        detail.setVehicle(vehicle);
        detail.setPromotions(getActivePromotions(vehicleId));
        detail.setReviews(listReviews(vehicleId));
        detail.setLowStock(vehicle.getStock() != null && vehicle.getStock() <= 5);
        return detail;
    }

    public List<Vehicle> lowStockVehicles() {
        return vehicles.values().stream()
                .filter(v -> v.getStock() != null && v.getStock() <= 5)
                .collect(Collectors.toList());
    }

    public synchronized Promotion savePromotion(Promotion promotion) {
        if (promotion.getVehicleId() == null || !vehicles.containsKey(promotion.getVehicleId())) {
            throw new IllegalArgumentException("需要先选择车型再关联活动");
        }
        if (promotion.getId() == null) {
            promotion.setId(nextId());
        }
        promotions.put(promotion.getId(), promotion);
        Vehicle vehicle = vehicles.get(promotion.getVehicleId());
        if (!vehicle.getPromotionIds().contains(promotion.getId())) {
            vehicle.getPromotionIds().add(promotion.getId());
        }
        return promotion;
    }

    public synchronized Promotion updatePromotionStatus(Long id, PromotionStatus status) {
        Promotion promotion = promotions.get(id);
        if (promotion == null) {
            throw new IllegalArgumentException("活动不存在");
        }
        promotion.setStatus(status);
        return promotion;
    }

    public List<Promotion> getActivePromotions(Long vehicleId) {
        LocalDate today = LocalDate.now();
        return promotions.values().stream()
                .filter(p -> Objects.equals(p.getVehicleId(), vehicleId))
                .filter(p -> p.getStatus() == PromotionStatus.ONLINE)
                .filter(p -> p.getStartDate() == null || !p.getStartDate().isAfter(today))
                .filter(p -> p.getEndDate() == null || !p.getEndDate().isBefore(today))
                .collect(Collectors.toList());
    }

    public synchronized OrderRecord createOrder(OrderRecord request) {
        Vehicle vehicle = vehicles.get(request.getVehicleId());
        if (vehicle == null) {
            throw new IllegalArgumentException("车型不存在");
        }
        UserProfile user = users.get(request.getUserId());
        if (user == null) {
            throw new IllegalArgumentException("用户不存在");
        }
        int qty = request.getQuantity() == null ? 1 : request.getQuantity();
        if (vehicle.getStock() != null && vehicle.getStock() < qty) {
            throw new IllegalStateException("库存不足");
        }
        OrderRecord order = new OrderRecord();
        order.setId(nextId());
        order.setOrderNo("EV" + orderNoGenerator.incrementAndGet());
        order.setUserId(request.getUserId());
        order.setVehicleId(request.getVehicleId());
        order.setQuantity(qty);
        order.setStore(request.getStore());
        order.setContactName(request.getContactName());
        order.setContactPhone(request.getContactPhone());
        order.setStatus(OrderStatus.WAIT_PAY);
        order.setCreatedAt(LocalDateTime.now());
        order.setFinancialPlanId(request.getFinancialPlanId());
        order.setRemark(request.getRemark());
        Promotion promotion = choosePromotion(request);
        if (promotion != null) {
            order.setPromotionId(promotion.getId());
            order.setPromotionTitle(promotion.getTitle());
        }
        BigDecimal unitPrice = vehicle.getGuidePrice();
        if (promotion != null && promotion.getDiscountRate() != null) {
            unitPrice = unitPrice.multiply(promotion.getDiscountRate()).setScale(2, RoundingMode.HALF_UP);
        }
        order.setPricePerUnit(unitPrice);
        BigDecimal total = unitPrice.multiply(BigDecimal.valueOf(qty));
        if (promotion != null && promotion.getSubsidy() != null) {
            total = total.subtract(promotion.getSubsidy()).max(BigDecimal.ZERO);
        }
        order.setTotalAmount(total);
        orders.put(order.getId(), order);
        if (vehicle.getStock() != null) {
            vehicle.setStock(vehicle.getStock() - qty);
        }
        return order;
    }

    private Promotion choosePromotion(OrderRecord request) {
        if (request.getPromotionId() != null) {
            return promotions.get(request.getPromotionId());
        }
        List<Promotion> active = getActivePromotions(request.getVehicleId());
        return CollectionUtils.isEmpty(active) ? null : active.get(0);
    }

    public synchronized OrderRecord cancelOrder(Long orderId, Long userId) {
        OrderRecord order = orders.get(orderId);
        if (order == null) {
            throw new IllegalArgumentException("订单不存在");
        }
        if (order.getStatus() != OrderStatus.WAIT_PAY) {
            throw new IllegalStateException("仅未支付订单可取消");
        }
        if (userId != null && !Objects.equals(userId, order.getUserId())) {
            throw new IllegalStateException("只能取消自己的订单");
        }
        order.setStatus(OrderStatus.CANCELLED);
        Vehicle vehicle = vehicles.get(order.getVehicleId());
        if (vehicle != null && vehicle.getStock() != null) {
            vehicle.setStock(vehicle.getStock() + order.getQuantity());
        }
        return order;
    }

    public synchronized OrderRecord markPaid(Long orderId) {
        OrderRecord order = orders.get(orderId);
        if (order == null) {
            throw new IllegalArgumentException("订单不存在");
        }
        if (order.getStatus() == OrderStatus.CANCELLED) {
            throw new IllegalStateException("订单已取消");
        }
        order.setStatus(OrderStatus.WAIT_PICKUP);
        order.setPaidAt(LocalDateTime.now());
        return order;
    }

    public synchronized OrderRecord markPicked(Long orderId) {
        OrderRecord order = orders.get(orderId);
        if (order == null) {
            throw new IllegalArgumentException("订单不存在");
        }
        if (order.getStatus() != OrderStatus.WAIT_PICKUP && order.getStatus() != OrderStatus.PAID) {
            throw new IllegalStateException("仅待提车状态可操作");
        }
        order.setStatus(OrderStatus.COMPLETED);
        order.setPickupAt(LocalDateTime.now());
        return order;
    }

    public List<OrderRecord> listOrders() {
        return new ArrayList<>(orders.values());
    }

    public List<OrderRecord> listOrders(Long userId) {
        return orders.values().stream()
                .filter(o -> Objects.equals(o.getUserId(), userId))
                .sorted(Comparator.comparing(OrderRecord::getCreatedAt).reversed())
                .collect(Collectors.toList());
    }

    public synchronized ReviewRecord addReview(ReviewRecord request) {
        OrderRecord order = orders.get(request.getOrderId());
        if (order == null || order.getStatus() != OrderStatus.COMPLETED) {
            throw new IllegalStateException("仅已提车订单可评价");
        }
        if (!Objects.equals(order.getUserId(), request.getUserId())) {
            throw new IllegalStateException("只能评价自己的订单");
        }
        request.setId(nextId());
        request.setVehicleId(order.getVehicleId());
        request.setCreatedAt(LocalDateTime.now());
        reviews.put(request.getId(), request);
        return request;
    }

    public List<ReviewRecord> listReviews(Long vehicleId) {
        return reviews.values().stream()
                .filter(r -> Objects.equals(r.getVehicleId(), vehicleId))
                .sorted(Comparator.comparing(ReviewRecord::getCreatedAt).reversed())
                .collect(Collectors.toList());
    }

    public synchronized TestDriveRecord createTestDrive(TestDriveRecord request) {
        if (!vehicles.containsKey(request.getVehicleId())) {
            throw new IllegalArgumentException("车型不存在");
        }
        if (!users.containsKey(request.getUserId())) {
            throw new IllegalArgumentException("用户不存在");
        }
        request.setId(nextId());
        request.setStatus(TestDriveStatus.PENDING);
        request.setCreatedAt(LocalDateTime.now());
        testDrives.put(request.getId(), request);
        return request;
    }

    public synchronized TestDriveRecord reviewTestDrive(Long id, TestDriveStatus status, String note) {
        TestDriveRecord record = testDrives.get(id);
        if (record == null) {
            throw new IllegalArgumentException("预约不存在");
        }
        record.setStatus(status);
        record.setAdminNote(note);
        return record;
    }

    public List<TestDriveRecord> listTestDrives(Long userId) {
        return testDrives.values().stream()
                .filter(r -> userId == null || Objects.equals(r.getUserId(), userId))
                .sorted(Comparator.comparing(TestDriveRecord::getCreatedAt).reversed())
                .collect(Collectors.toList());
    }

    public List<Vehicle> compareVehicles(List<Long> vehicleIds) {
        return vehicleIds.stream()
                .map(vehicles::get)
                .filter(Objects::nonNull)
                .collect(Collectors.toList());
    }

    public List<Vehicle> recommendVehicles(Long userId) {
        List<Long> viewed = browseHistory.getOrDefault(userId, Collections.emptyList());
        Optional<String> recentBrand = viewed.stream()
                .map(vehicles::get)
                .filter(Objects::nonNull)
                .map(Vehicle::getBrand)
                .findFirst();
        return vehicles.values().stream()
                .filter(v -> !recentBrand.isPresent() || v.getBrand().equalsIgnoreCase(recentBrand.get()))
                .sorted(Comparator.comparing(Vehicle::getStock, Comparator.nullsLast(Comparator.reverseOrder())))
                .limit(3)
                .collect(Collectors.toList());
    }

    public void recordBrowse(Long userId, Long vehicleId) {
        browseHistory.computeIfAbsent(userId, k -> new CopyOnWriteArrayList<>()).add(0, vehicleId);
        List<Long> list = browseHistory.get(userId);
        if (list.size() > 20) {
            list.remove(list.size() - 1);
        }
    }

    public synchronized void subscribeInventory(Long userId, Long vehicleId) {
        inventorySubscriptions.computeIfAbsent(vehicleId, k -> new ArrayList<>());
        List<Long> subscribers = inventorySubscriptions.get(vehicleId);
        if (!subscribers.contains(userId)) {
            subscribers.add(userId);
        }
    }

    public synchronized Vehicle restockVehicle(Long vehicleId, int delta) {
        Vehicle vehicle = vehicles.get(vehicleId);
        if (vehicle == null) {
            throw new IllegalArgumentException("车辆不存在");
        }
        int before = vehicle.getStock() == null ? 0 : vehicle.getStock();
        vehicle.setStock(before + delta);
        if (before <= 0 && vehicle.getStock() > 0) {
            inventorySubscriptions.remove(vehicleId);
        }
        return vehicle;
    }

    public Map<String, Object> stats(LocalDate start, LocalDate end) {
        LocalDateTime from = start == null ? LocalDate.MIN.atStartOfDay() : start.atStartOfDay();
        LocalDateTime to = end == null ? LocalDateTime.now() : end.plusDays(1).atStartOfDay();
        List<OrderRecord> scoped = orders.values().stream()
                .filter(o -> o.getCreatedAt() != null && !o.getCreatedAt().isBefore(from) && o.getCreatedAt().isBefore(to))
                .filter(o -> o.getStatus() != OrderStatus.CANCELLED)
                .collect(Collectors.toList());

        Map<Long, Integer> qtyByVehicle = new HashMap<>();
        Map<Long, BigDecimal> amountByVehicle = new HashMap<>();
        for (OrderRecord order : scoped) {
            qtyByVehicle.merge(order.getVehicleId(), order.getQuantity(), Integer::sum);
            if (order.getTotalAmount() != null) {
                amountByVehicle.merge(order.getVehicleId(), order.getTotalAmount(), BigDecimal::add);
            }
        }
        List<Map<String, Object>> topVehicles = qtyByVehicle.entrySet().stream()
                .sorted(Map.Entry.<Long, Integer>comparingByValue().reversed())
                .limit(5)
                .map(e -> {
                    Map<String, Object> map = new HashMap<>();
                    Vehicle vehicle = vehicles.get(e.getKey());
                    map.put("vehicle", vehicle);
                    map.put("qty", e.getValue());
                    map.put("amount", amountByVehicle.getOrDefault(e.getKey(), BigDecimal.ZERO));
                    return map;
                }).collect(Collectors.toList());

        Map<String, Long> brandShare = scoped.stream()
                .map(o -> vehicles.get(o.getVehicleId()))
                .filter(Objects::nonNull)
                .collect(Collectors.groupingBy(Vehicle::getBrand, Collectors.counting()));

        Map<String, Long> rangeShare = scoped.stream()
                .map(o -> vehicles.get(o.getVehicleId()))
                .filter(Objects::nonNull)
                .collect(Collectors.groupingBy(this::rangeBucket, Collectors.counting()));

        long newUsers = users.values().stream()
                .filter(u -> u.getRegisterTime() != null)
                .filter(u -> !u.getRegisterTime().isBefore(from) && u.getRegisterTime().isBefore(to))
                .count();

        BigDecimal totalAmount = scoped.stream()
                .map(OrderRecord::getTotalAmount)
                .filter(Objects::nonNull)
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        Map<String, Object> result = new HashMap<>();
        result.put("top5Vehicles", topVehicles);
        result.put("brandShare", brandShare);
        result.put("rangeShare", rangeShare);
        result.put("newUsers", newUsers);
        result.put("totalAmount", totalAmount);
        result.put("totalOrders", scoped.size());
        return result;
    }

    private String rangeBucket(Vehicle vehicle) {
        if (vehicle.getRangeKm() == null) {
            return "未知";
        }
        int r = vehicle.getRangeKm();
        if (r < 400) {
            return "＜400km";
        }
        if (r < 600) {
            return "400-600km";
        }
        return "≥600km";
    }

    public UserProfile saveUser(UserProfile userProfile) {
        if (userProfile.getId() == null) {
            userProfile.setId(nextId());
            userProfile.setRegisterTime(LocalDateTime.now());
        }
        users.put(userProfile.getId(), userProfile);
        return userProfile;
    }

    public Collection<UserProfile> listUsers() {
        return users.values();
    }

    public FinancialPlan saveFinancialPlan(FinancialPlan plan) {
        if (!vehicles.containsKey(plan.getVehicleId())) {
            throw new IllegalArgumentException("车型不存在");
        }
        if (plan.getId() == null) {
            plan.setId(nextId());
        }
        financialPlans.put(plan.getId(), plan);
        return plan;
    }

    public List<FinancialPlan> listFinancialPlans(Long vehicleId) {
        return financialPlans.values().stream()
                .filter(p -> vehicleId == null || Objects.equals(p.getVehicleId(), vehicleId))
                .collect(Collectors.toList());
    }
}
