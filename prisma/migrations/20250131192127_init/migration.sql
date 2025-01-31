-- CreateEnum
CREATE TYPE "OrderType" AS ENUM ('ORDER', 'RETURN', 'REPLACE');

-- CreateEnum
CREATE TYPE "OrderStatus" AS ENUM ('NEW', 'DELIVERED', 'CANCELED');

-- CreateEnum
CREATE TYPE "PaymentType" AS ENUM ('CASH', 'TRANSFER');

-- CreateEnum
CREATE TYPE "DealType" AS ENUM ('SALE', 'PURCHASE');

-- CreateEnum
CREATE TYPE "Role" AS ENUM ('ADMIN', 'AGENT', 'OPERATOR', 'CASHIER', 'PARTNER', 'SUPERVISOR', 'MANAGER', 'EXPEDITOR', 'MERCHANDISER', 'WAREHOUSEMAN');

-- CreateEnum
CREATE TYPE "WarehouseType" AS ENUM ('DISTRIBUTION', 'RETURNS', 'RESERVE');

-- CreateTable
CREATE TABLE "Order" (
    "id" SERIAL NOT NULL,
    "type" "OrderType" NOT NULL,
    "status" "OrderStatus" NOT NULL,
    "payment_type" INTEGER NOT NULL,
    "order_date" TIMESTAMP(3) NOT NULL,
    "load_date" TIMESTAMP(3) NOT NULL,
    "deliver_date" TIMESTAMP(3) NOT NULL,
    "status_date" TIMESTAMP(3) NOT NULL,
    "agent_id" INTEGER NOT NULL,
    "expeditor_id" INTEGER NOT NULL,
    "client_id" INTEGER NOT NULL,
    "territory_id" INTEGER NOT NULL,
    "warehouse_id" INTEGER NOT NULL,
    "sum" DOUBLE PRECISION NOT NULL,
    "debt" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "discount" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "amount" INTEGER NOT NULL,
    "volume" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "note_id" INTEGER NOT NULL,
    "comment" TEXT,
    "created_user_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Order_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "OrderItem" (
    "id" SERIAL NOT NULL,
    "count" INTEGER NOT NULL,
    "price" DOUBLE PRECISION NOT NULL,
    "summa" DOUBLE PRECISION NOT NULL,
    "volume" DOUBLE PRECISION NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,
    "defect" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "comment" TEXT NOT NULL,
    "discount" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "discount_id" INTEGER NOT NULL,
    "order_id" INTEGER NOT NULL,
    "store_id" INTEGER NOT NULL,
    "prod_cat_id" INTEGER NOT NULL,
    "client_id" INTEGER NOT NULL,
    "client_cat_id" INTEGER NOT NULL,
    "territory_id" INTEGER NOT NULL,
    "currency_id" INTEGER NOT NULL,
    "unit_id" INTEGER NOT NULL,

    CONSTRAINT "OrderItem_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "note" (
    "id" SERIAL NOT NULL,
    "sort" INTEGER,
    "name" TEXT NOT NULL,
    "content" TEXT,
    "is_active" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "note_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "bonus" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "comment" TEXT,
    "bonus" DOUBLE PRECISION NOT NULL,
    "value" DOUBLE PRECISION NOT NULL,
    "parent" INTEGER NOT NULL,
    "manual" INTEGER NOT NULL,
    "min_count" DOUBLE PRECISION NOT NULL,
    "client_cat_id" INTEGER NOT NULL,
    "date_from" TIMESTAMP(3) NOT NULL,
    "date_to" TIMESTAMP(3) NOT NULL,
    "in_block" INTEGER NOT NULL DEFAULT 0,
    "max_bonus" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "is_public" BOOLEAN NOT NULL DEFAULT true,
    "is_active" BOOLEAN NOT NULL DEFAULT false,
    "bonus_type_id" INTEGER NOT NULL,
    "product_id" INTEGER NOT NULL,
    "currency_id" INTEGER NOT NULL,
    "price_type_id" INTEGER NOT NULL,
    "agent_id" INTEGER NOT NULL,
    "city_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "bonus_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "bonus_type" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "code" TEXT,

    CONSTRAINT "bonus_type_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "bonus_order" (
    "id" SERIAL NOT NULL,
    "count" INTEGER NOT NULL,
    "volume" DOUBLE PRECISION NOT NULL,
    "product_id" INTEGER NOT NULL,
    "prod_cat_id" INTEGER NOT NULL,
    "order_id" INTEGER NOT NULL,
    "bonus_id" INTEGER NOT NULL,
    "unit_id" INTEGER NOT NULL,
    "curreny_id" INTEGER NOT NULL,
    "store_id" INTEGER NOT NULL,

    CONSTRAINT "bonus_order_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "bonus_order_detail" (
    "id" SERIAL NOT NULL,
    "count" INTEGER NOT NULL,
    "volume" DOUBLE PRECISION NOT NULL,
    "bonus_order_id" INTEGER NOT NULL,

    CONSTRAINT "bonus_order_detail_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "client" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "legal_name" VARCHAR(255) NOT NULL,
    "comment" TEXT,
    "address" VARCHAR(255) NOT NULL,
    "landmark" VARCHAR(255) NOT NULL,
    "lat" DOUBLE PRECISION NOT NULL,
    "long" DOUBLE PRECISION NOT NULL,
    "phone" VARCHAR(20) NOT NULL,
    "add_phone" VARCHAR(20) NOT NULL,
    "contact_person" VARCHAR(255) NOT NULL,
    "inn" VARCHAR(20) NOT NULL,
    "code" VARCHAR(20) NOT NULL,
    "pinfl" VARCHAR(20) NOT NULL,
    "contract" VARCHAR(255) NOT NULL,
    "account" VARCHAR(255) NOT NULL,
    "bank" VARCHAR(255) NOT NULL,
    "mfo" VARCHAR(20) NOT NULL,
    "oked" VARCHAR(20) NOT NULL,
    "code_nds" VARCHAR(20) NOT NULL,
    "balance1" DOUBLE PRECISION NOT NULL,
    "balance2" DOUBLE PRECISION NOT NULL,
    "bar_code" VARCHAR(255) NOT NULL,
    "date_exp" TIMESTAMP(3) NOT NULL,
    "allow_consig" BOOLEAN NOT NULL DEFAULT false,
    "allow_credit" BOOLEAN NOT NULL DEFAULT false,
    "audit" BOOLEAN NOT NULL DEFAULT false,
    "is_active" BOOLEAN NOT NULL DEFAULT false,
    "region_id" INTEGER NOT NULL,
    "territory_id" INTEGER NOT NULL,
    "category_id" INTEGER NOT NULL,
    "type_id" INTEGER NOT NULL,
    "channel_id" INTEGER NOT NULL,
    "class_id" INTEGER NOT NULL,
    "bonus_id" INTEGER NOT NULL,
    "discount_id" INTEGER NOT NULL,
    "expeditor_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "client_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "client_category" (
    "id" SERIAL NOT NULL,
    "code" VARCHAR(20),
    "name" VARCHAR(255) NOT NULL,
    "color" VARCHAR(7) NOT NULL DEFAULT '#000000',
    "description" TEXT,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "client_category_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "client_type" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "code" VARCHAR(20),
    "color" VARCHAR(7) NOT NULL DEFAULT '#000000',
    "is_active" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "client_type_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "client_channel" (
    "id" SERIAL NOT NULL,
    "code" VARCHAR(20),
    "name" VARCHAR(255) NOT NULL,

    CONSTRAINT "client_channel_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "client_class" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(255) NOT NULL,

    CONSTRAINT "client_class_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "client_transaction" (
    "id" SERIAL NOT NULL,
    "code" INTEGER NOT NULL,
    "history" INTEGER NOT NULL,
    "comment" TEXT NOT NULL,
    "sum" DOUBLE PRECISION NOT NULL,
    "convertation" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "comission" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "computation" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "currency_rate" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "date_exp" TIMESTAMP(3) NOT NULL,
    "date_close" TIMESTAMP(3) NOT NULL,
    "client_id" INTEGER NOT NULL,
    "order_id" INTEGER NOT NULL,
    "currency_id" INTEGER NOT NULL,
    "cashbox_id" INTEGER NOT NULL,
    "user_id" INTEGER NOT NULL,
    "agent_id" INTEGER NOT NULL,
    "expeditor_id" INTEGER NOT NULL,
    "confirm_id" INTEGER NOT NULL,
    "confirm_user" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "client_transaction_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "defect" (
    "id" SERIAL NOT NULL,
    "count" INTEGER NOT NULL,
    "defect_type" INTEGER NOT NULL,
    "order_id" INTEGER NOT NULL,
    "client_cat_id" INTEGER NOT NULL,
    "client_id" INTEGER NOT NULL,
    "agent_id" INTEGER NOT NULL,
    "city_id" INTEGER NOT NULL,
    "price_type_id" INTEGER NOT NULL,

    CONSTRAINT "defect_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DefectDetail" (
    "id" SERIAL NOT NULL,
    "count" INTEGER NOT NULL,
    "unit" INTEGER NOT NULL,
    "price" DOUBLE PRECISION NOT NULL,
    "sum" DOUBLE PRECISION NOT NULL,
    "volume" DOUBLE PRECISION NOT NULL,
    "reason" TEXT NOT NULL,
    "exp_date" TIMESTAMP(3) NOT NULL,
    "order_defect_id" INTEGER NOT NULL,
    "product_id" INTEGER NOT NULL,
    "prod_cat_id" INTEGER NOT NULL,

    CONSTRAINT "DefectDetail_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DiscountManual" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "comment" TEXT,
    "discount" DOUBLE PRECISION NOT NULL,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "agent_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "DiscountManual_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Discount" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "comment" TEXT,
    "parent" INTEGER NOT NULL,
    "value" DOUBLE PRECISION NOT NULL,
    "skidka" DOUBLE PRECISION NOT NULL,
    "budget" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "date_from" TIMESTAMP(3) NOT NULL,
    "date_to" TIMESTAMP(3) NOT NULL,
    "is_public" BOOLEAN NOT NULL DEFAULT true,
    "is_active" BOOLEAN NOT NULL DEFAULT false,
    "price_type" INTEGER NOT NULL,
    "discount_type_id" INTEGER NOT NULL,
    "prod_id" INTEGER NOT NULL,
    "client_cat_id" INTEGER NOT NULL,
    "currency_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Discount_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "currency" (
    "id" SERIAL NOT NULL,
    "title" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "code" TEXT NOT NULL,
    "css_class" TEXT NOT NULL,
    "code_id" INTEGER,
    "region_id" INTEGER NOT NULL,
    "time" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "currency_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "unit" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "code" TEXT,
    "is_active" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "unit_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "region" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "code" TEXT NOT NULL,

    CONSTRAINT "region_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "territory" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "code" INTEGER,
    "sort" INTEGER,
    "lat" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "lon" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "in_report" BOOLEAN NOT NULL DEFAULT true,
    "region_id" INTEGER NOT NULL,
    "time" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "territory_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "producer" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "country" TEXT,
    "sort" INTEGER,
    "is_active" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "producer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "brand" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "sort" INTEGER,
    "is_active" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "brand_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "segment" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "sort" INTEGER,
    "is_active" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "segment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "visiting" (
    "id" SERIAL NOT NULL,
    "day" INTEGER NOT NULL,
    "sort" INTEGER NOT NULL,
    "week_type" INTEGER NOT NULL DEFAULT 0,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "agent_id" INTEGER NOT NULL,
    "client_id" INTEGER NOT NULL,
    "time" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "visiting_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "cashbox" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "currency_id" INTEGER NOT NULL,
    "time" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "cashbox_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "consumption" (
    "id" SERIAL NOT NULL,
    "sum" DOUBLE PRECISION NOT NULL,
    "comment" TEXT NOT NULL,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "type" INTEGER NOT NULL,
    "currency_id" INTEGER NOT NULL,
    "cashbox_id" INTEGER NOT NULL,
    "ship_trans_id" INTEGER NOT NULL,
    "disp_id" INTEGER NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,
    "time" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "consumption_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "corrector" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "comment" TEXT NOT NULL,
    "count" INTEGER NOT NULL,
    "fact" INTEGER NOT NULL,
    "type" INTEGER NOT NULL,
    "parent" INTEGER NOT NULL,
    "price" DOUBLE PRECISION NOT NULL,
    "armor" DOUBLE PRECISION NOT NULL,
    "is_available" BOOLEAN NOT NULL DEFAULT true,
    "product_id" INTEGER NOT NULL,
    "store_id" INTEGER NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,
    "timestamp" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "corrector_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "excretion" (
    "id" SERIAL NOT NULL,
    "code" INTEGER NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,
    "comment" TEXT NOT NULL,
    "count" INTEGER NOT NULL,
    "responsible" BOOLEAN NOT NULL,
    "store_id" INTEGER NOT NULL,
    "product_id" INTEGER NOT NULL,
    "prod_cat_id" INTEGER NOT NULL,
    "timestamp" TIMESTAMP(3) NOT NULL,
    "parent_time" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "excretion_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "refusal_reason" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "comment" TEXT,
    "is_active" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "refusal_reason_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "return_reason" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "comment" TEXT,
    "is_active" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "return_reason_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "photoreport_category" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "sort" INTEGER,
    "is_active" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "photoreport_category_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "inventory_type" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "type" TEXT,
    "code" TEXT,
    "title" TEXT,
    "sort" INTEGER,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "groupId" INTEGER NOT NULL,

    CONSTRAINT "inventory_type_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "inventory_group" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "is_active" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "inventory_group_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "task_type" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "code" TEXT,

    CONSTRAINT "task_type_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "trade_direction" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "code" TEXT,

    CONSTRAINT "trade_direction_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "distribution_channel" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "code" TEXT,

    CONSTRAINT "distribution_channel_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "case_type" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "code" TEXT,
    "shortName" TEXT,
    "is_active" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "case_type_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "knowledge_base_type" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "roles" "Role"[],
    "is_active" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "knowledge_base_type_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "knowledge_base" (
    "id" SERIAL NOT NULL,
    "title" TEXT NOT NULL,
    "content" TEXT NOT NULL,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "type_id" INTEGER NOT NULL,
    "roles" "Role"[],

    CONSTRAINT "knowledge_base_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "container" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "sort" INTEGER,
    "is_active" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "container_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "payment_method" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "code" TEXT NOT NULL,
    "title" TEXT NOT NULL,

    CONSTRAINT "payment_method_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "price_type" (
    "id" SERIAL NOT NULL,
    "sort" INTEGER,
    "name" TEXT NOT NULL,
    "code" TEXT,
    "comment" TEXT,
    "type" "DealType" NOT NULL,
    "hand_edit" BOOLEAN NOT NULL DEFAULT false,
    "for_client" BOOLEAN NOT NULL DEFAULT false,
    "valyuta_id" INTEGER NOT NULL,
    "currency_id" INTEGER NOT NULL,
    "is_active" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "price_type_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "price" (
    "id" SERIAL NOT NULL,
    "price" DOUBLE PRECISION NOT NULL,
    "code" TEXT NOT NULL,
    "code_doc" INTEGER NOT NULL,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "type_id" INTEGER NOT NULL,
    "currency_id" INTEGER NOT NULL,
    "product_id" INTEGER NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "price_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "product" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "code" TEXT,
    "volume" DOUBLE PRECISION NOT NULL,
    "weight" DOUBLE PRECISION NOT NULL,
    "packs_per_box" INTEGER NOT NULL,
    "quant_per_pack" INTEGER NOT NULL,
    "prod_cat_id" INTEGER NOT NULL,
    "unit_id" INTEGER NOT NULL,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "sort" INTEGER,
    "store_period" INTEGER NOT NULL,
    "sap_code" INTEGER NOT NULL,
    "bar_code" INTEGER NOT NULL,
    "sub_cat_id" INTEGER NOT NULL,
    "prod_grp_id" INTEGER NOT NULL,
    "brand_id" INTEGER NOT NULL,
    "producer_id" INTEGER NOT NULL,
    "segmentId" INTEGER NOT NULL,
    "container_id" INTEGER NOT NULL,
    "ikpu" INTEGER NOT NULL,
    "pack" INTEGER NOT NULL,
    "block" INTEGER NOT NULL,
    "cs_product" INTEGER NOT NULL,
    "is_mml" BOOLEAN NOT NULL DEFAULT false,
    "is_our" BOOLEAN NOT NULL DEFAULT true,
    "is_local" BOOLEAN NOT NULL DEFAULT true,
    "trade_id" INTEGER NOT NULL,
    "cd_id" INTEGER NOT NULL,
    "case_type_id" INTEGER NOT NULL,
    "cd_cat_id" INTEGER NOT NULL,
    "cs_rate" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "product_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "product_category" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "code" TEXT,
    "sort" INTEGER NOT NULL,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "unit_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "product_category_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "product_sub_category" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "code" TEXT,
    "sort" INTEGER NOT NULL,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "unit_id" INTEGER NOT NULL,

    CONSTRAINT "product_sub_category_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "product_case_type" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "short" TEXT NOT NULL,
    "code" INTEGER NOT NULL,
    "is_active" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "product_case_type_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "product_cat_group" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "sort" INTEGER NOT NULL,
    "code" INTEGER NOT NULL,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "unit_id" INTEGER NOT NULL,
    "product_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "product_cat_group_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "product_group" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "code" TEXT NOT NULL,
    "is_active" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "product_group_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Purchase" (
    "id" SERIAL NOT NULL,
    "code" INTEGER NOT NULL,
    "count" INTEGER NOT NULL,
    "status" INTEGER NOT NULL,
    "debt" INTEGER NOT NULL,
    "num_purchase" INTEGER NOT NULL,
    "summa" DOUBLE PRECISION NOT NULL,
    "comment" TEXT NOT NULL,
    "shipped_id" INTEGER NOT NULL,
    "filial_id" INTEGER NOT NULL,
    "price_type_id" INTEGER NOT NULL,
    "store_id" INTEGER NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,
    "time" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Purchase_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PurchaseDetail" (
    "id" SERIAL NOT NULL,
    "count" INTEGER NOT NULL,
    "price" DOUBLE PRECISION NOT NULL,
    "sum" DOUBLE PRECISION NOT NULL,
    "volume" DOUBLE PRECISION NOT NULL,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "purchase_id" INTEGER NOT NULL,
    "product_id" INTEGER NOT NULL,
    "prod_cat_id" INTEGER NOT NULL,
    "currency_id" INTEGER NOT NULL,
    "unit_id" INTEGER NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "PurchaseDetail_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PurchaseRefund" (
    "id" SERIAL NOT NULL,
    "code" INTEGER NOT NULL,
    "count" INTEGER NOT NULL,
    "status" INTEGER NOT NULL,
    "type" INTEGER NOT NULL,
    "debt" INTEGER NOT NULL,
    "sum" DOUBLE PRECISION NOT NULL,
    "comment" TEXT NOT NULL,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "filial_id" INTEGER NOT NULL,
    "price_type_id" INTEGER NOT NULL,
    "shipped_id" INTEGER NOT NULL,
    "currency_id" INTEGER NOT NULL,
    "store_id" INTEGER NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,
    "time" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "PurchaseRefund_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PurchaseRefundDetail" (
    "id" SERIAL NOT NULL,
    "count" INTEGER NOT NULL,
    "price" DOUBLE PRECISION NOT NULL,
    "summa" DOUBLE PRECISION NOT NULL,
    "volume" DOUBLE PRECISION NOT NULL,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "product_id" INTEGER NOT NULL,
    "prod_cat_id" INTEGER NOT NULL,
    "purchase_id" INTEGER NOT NULL,
    "currency_id" INTEGER NOT NULL,
    "unit_id" INTEGER NOT NULL,
    "time" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "PurchaseRefundDetail_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Replace" (
    "id" SERIAL NOT NULL,
    "count" INTEGER NOT NULL,
    "status" INTEGER NOT NULL,
    "reason" TEXT NOT NULL,
    "comment" TEXT NOT NULL,
    "summa" DOUBLE PRECISION NOT NULL,
    "volume" DOUBLE PRECISION NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,
    "date_delivered" TIMESTAMP(3) NOT NULL,
    "agent_id" INTEGER NOT NULL,
    "expeditor_id" INTEGER NOT NULL,
    "city_id" INTEGER NOT NULL,
    "client_id" INTEGER NOT NULL,
    "client_cat_id" INTEGER NOT NULL,
    "order_id" INTEGER NOT NULL,
    "replace_type" INTEGER NOT NULL,
    "defect_id" INTEGER NOT NULL,
    "currency_id" INTEGER NOT NULL,
    "price_type" INTEGER NOT NULL,

    CONSTRAINT "Replace_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "replace_detail" (
    "id" SERIAL NOT NULL,
    "price" DOUBLE PRECISION NOT NULL,
    "sum" DOUBLE PRECISION NOT NULL,
    "volume" DOUBLE PRECISION NOT NULL,
    "unit" INTEGER NOT NULL,
    "count" INTEGER NOT NULL,
    "prod_cat_id" INTEGER NOT NULL,
    "product_id" INTEGER NOT NULL,
    "order_id" INTEGER NOT NULL,
    "replace_id" INTEGER NOT NULL,
    "store_id" INTEGER NOT NULL,

    CONSTRAINT "replace_detail_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "replace_type" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "code" TEXT NOT NULL,

    CONSTRAINT "replace_type_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "store" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "code" TEXT,
    "stockman" INTEGER NOT NULL,
    "count" INTEGER NOT NULL,
    "van_selling" INTEGER NOT NULL,
    "minus_count" INTEGER NOT NULL,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "time" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "store_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "store_detail" (
    "id" SERIAL NOT NULL,
    "count" INTEGER NOT NULL,
    "store_id" INTEGER NOT NULL,
    "product_id" INTEGER NOT NULL,
    "prod_cat_id" INTEGER NOT NULL,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "time" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "store_detail_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user" (
    "id" SERIAL NOT NULL,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "middle_name" TEXT,
    "email" TEXT,
    "phone" TEXT,
    "login" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "role" "Role" NOT NULL,
    "code" INTEGER NOT NULL,
    "pay" INTEGER NOT NULL,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "user_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "admin" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,

    CONSTRAINT "admin_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "agent" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "filter" INTEGER NOT NULL,
    "code" INTEGER NOT NULL,
    "address" TEXT NOT NULL,
    "passport_copy" TEXT NOT NULL,
    "date_birth" TIMESTAMP(3) NOT NULL,
    "first_visit" TIMESTAMP(3) NOT NULL,
    "audit" INTEGER NOT NULL,
    "cashbox" INTEGER NOT NULL,
    "van_selling" INTEGER NOT NULL,

    CONSTRAINT "agent_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "operator" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,

    CONSTRAINT "operator_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "cashier" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,

    CONSTRAINT "cashier_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "partner" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,

    CONSTRAINT "partner_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "supervisor" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,

    CONSTRAINT "supervisor_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "manager" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,

    CONSTRAINT "manager_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "expeditor" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "pinfl" VARCHAR(14) NOT NULL,
    "car_brand" TEXT,
    "car_num" TEXT,
    "address" TEXT NOT NULL,
    "passport_copy" TEXT NOT NULL,
    "date_birth" TIMESTAMP(3) NOT NULL,
    "code" INTEGER NOT NULL,
    "defect_store" INTEGER NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "expeditor_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "merchandiser" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,

    CONSTRAINT "merchandiser_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "warehouseman" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,

    CONSTRAINT "warehouseman_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "warehouse" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "code" TEXT,
    "code_etcn" TEXT,
    "type" "WarehouseType",
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "balance_control" BOOLEAN NOT NULL DEFAULT false,
    "warehouseman_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "warehouse_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "supplier" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "code" TEXT,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "supplier_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "reciept" (
    "id" SERIAL NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,
    "supplier_id" INTEGER NOT NULL,
    "warehouse_id" INTEGER NOT NULL,
    "price_type_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "reciept_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_warehouse_payment_method" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "_warehouse_agent" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "_partner_product_categories" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "_ExpeditorToTerritory" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "bonus_order_detail_bonus_order_id_key" ON "bonus_order_detail"("bonus_order_id");

-- CreateIndex
CREATE UNIQUE INDEX "PurchaseDetail_purchase_id_key" ON "PurchaseDetail"("purchase_id");

-- CreateIndex
CREATE UNIQUE INDEX "replace_detail_replace_id_key" ON "replace_detail"("replace_id");

-- CreateIndex
CREATE UNIQUE INDEX "store_detail_store_id_key" ON "store_detail"("store_id");

-- CreateIndex
CREATE UNIQUE INDEX "user_login_key" ON "user"("login");

-- CreateIndex
CREATE UNIQUE INDEX "admin_user_id_key" ON "admin"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "agent_user_id_key" ON "agent"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "operator_user_id_key" ON "operator"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "cashier_user_id_key" ON "cashier"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "partner_user_id_key" ON "partner"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "supervisor_user_id_key" ON "supervisor"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "manager_user_id_key" ON "manager"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "expeditor_user_id_key" ON "expeditor"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "merchandiser_user_id_key" ON "merchandiser"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "warehouseman_user_id_key" ON "warehouseman"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "_warehouse_payment_method_AB_unique" ON "_warehouse_payment_method"("A", "B");

-- CreateIndex
CREATE INDEX "_warehouse_payment_method_B_index" ON "_warehouse_payment_method"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_warehouse_agent_AB_unique" ON "_warehouse_agent"("A", "B");

-- CreateIndex
CREATE INDEX "_warehouse_agent_B_index" ON "_warehouse_agent"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_partner_product_categories_AB_unique" ON "_partner_product_categories"("A", "B");

-- CreateIndex
CREATE INDEX "_partner_product_categories_B_index" ON "_partner_product_categories"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_ExpeditorToTerritory_AB_unique" ON "_ExpeditorToTerritory"("A", "B");

-- CreateIndex
CREATE INDEX "_ExpeditorToTerritory_B_index" ON "_ExpeditorToTerritory"("B");

-- AddForeignKey
ALTER TABLE "Order" ADD CONSTRAINT "Order_payment_type_fkey" FOREIGN KEY ("payment_type") REFERENCES "price_type"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Order" ADD CONSTRAINT "Order_agent_id_fkey" FOREIGN KEY ("agent_id") REFERENCES "agent"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Order" ADD CONSTRAINT "Order_expeditor_id_fkey" FOREIGN KEY ("expeditor_id") REFERENCES "expeditor"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Order" ADD CONSTRAINT "Order_client_id_fkey" FOREIGN KEY ("client_id") REFERENCES "client"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Order" ADD CONSTRAINT "Order_territory_id_fkey" FOREIGN KEY ("territory_id") REFERENCES "territory"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Order" ADD CONSTRAINT "Order_warehouse_id_fkey" FOREIGN KEY ("warehouse_id") REFERENCES "warehouse"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Order" ADD CONSTRAINT "Order_note_id_fkey" FOREIGN KEY ("note_id") REFERENCES "note"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Order" ADD CONSTRAINT "Order_created_user_id_fkey" FOREIGN KEY ("created_user_id") REFERENCES "user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "OrderItem" ADD CONSTRAINT "OrderItem_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "Order"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "OrderItem" ADD CONSTRAINT "OrderItem_prod_cat_id_fkey" FOREIGN KEY ("prod_cat_id") REFERENCES "product_category"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "OrderItem" ADD CONSTRAINT "OrderItem_client_id_fkey" FOREIGN KEY ("client_id") REFERENCES "client"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "OrderItem" ADD CONSTRAINT "OrderItem_client_cat_id_fkey" FOREIGN KEY ("client_cat_id") REFERENCES "client_category"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "OrderItem" ADD CONSTRAINT "OrderItem_territory_id_fkey" FOREIGN KEY ("territory_id") REFERENCES "territory"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "OrderItem" ADD CONSTRAINT "OrderItem_currency_id_fkey" FOREIGN KEY ("currency_id") REFERENCES "currency"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "OrderItem" ADD CONSTRAINT "OrderItem_unit_id_fkey" FOREIGN KEY ("unit_id") REFERENCES "unit"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "bonus" ADD CONSTRAINT "bonus_bonus_type_id_fkey" FOREIGN KEY ("bonus_type_id") REFERENCES "bonus_type"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "bonus" ADD CONSTRAINT "bonus_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "product"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "bonus" ADD CONSTRAINT "bonus_currency_id_fkey" FOREIGN KEY ("currency_id") REFERENCES "currency"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "bonus" ADD CONSTRAINT "bonus_price_type_id_fkey" FOREIGN KEY ("price_type_id") REFERENCES "price_type"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "bonus" ADD CONSTRAINT "bonus_agent_id_fkey" FOREIGN KEY ("agent_id") REFERENCES "agent"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "bonus" ADD CONSTRAINT "bonus_city_id_fkey" FOREIGN KEY ("city_id") REFERENCES "territory"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "bonus_order" ADD CONSTRAINT "bonus_order_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "product"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "bonus_order" ADD CONSTRAINT "bonus_order_prod_cat_id_fkey" FOREIGN KEY ("prod_cat_id") REFERENCES "product_category"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "bonus_order" ADD CONSTRAINT "bonus_order_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "Order"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "bonus_order" ADD CONSTRAINT "bonus_order_bonus_id_fkey" FOREIGN KEY ("bonus_id") REFERENCES "bonus"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "bonus_order" ADD CONSTRAINT "bonus_order_curreny_id_fkey" FOREIGN KEY ("curreny_id") REFERENCES "currency"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "bonus_order_detail" ADD CONSTRAINT "bonus_order_detail_bonus_order_id_fkey" FOREIGN KEY ("bonus_order_id") REFERENCES "bonus_order"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "client" ADD CONSTRAINT "client_region_id_fkey" FOREIGN KEY ("region_id") REFERENCES "region"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "client" ADD CONSTRAINT "client_territory_id_fkey" FOREIGN KEY ("territory_id") REFERENCES "territory"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "client" ADD CONSTRAINT "client_category_id_fkey" FOREIGN KEY ("category_id") REFERENCES "client_category"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "client" ADD CONSTRAINT "client_type_id_fkey" FOREIGN KEY ("type_id") REFERENCES "client_type"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "client" ADD CONSTRAINT "client_channel_id_fkey" FOREIGN KEY ("channel_id") REFERENCES "client_channel"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "client" ADD CONSTRAINT "client_class_id_fkey" FOREIGN KEY ("class_id") REFERENCES "client_class"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "client" ADD CONSTRAINT "client_bonus_id_fkey" FOREIGN KEY ("bonus_id") REFERENCES "bonus"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "client" ADD CONSTRAINT "client_discount_id_fkey" FOREIGN KEY ("discount_id") REFERENCES "Discount"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "client" ADD CONSTRAINT "client_expeditor_id_fkey" FOREIGN KEY ("expeditor_id") REFERENCES "expeditor"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "client_transaction" ADD CONSTRAINT "client_transaction_client_id_fkey" FOREIGN KEY ("client_id") REFERENCES "client"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "client_transaction" ADD CONSTRAINT "client_transaction_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "Order"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "client_transaction" ADD CONSTRAINT "client_transaction_currency_id_fkey" FOREIGN KEY ("currency_id") REFERENCES "currency"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "client_transaction" ADD CONSTRAINT "client_transaction_cashbox_id_fkey" FOREIGN KEY ("cashbox_id") REFERENCES "cashbox"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "client_transaction" ADD CONSTRAINT "client_transaction_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "client_transaction" ADD CONSTRAINT "client_transaction_agent_id_fkey" FOREIGN KEY ("agent_id") REFERENCES "agent"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "client_transaction" ADD CONSTRAINT "client_transaction_expeditor_id_fkey" FOREIGN KEY ("expeditor_id") REFERENCES "expeditor"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "defect" ADD CONSTRAINT "defect_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "Order"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "defect" ADD CONSTRAINT "defect_client_cat_id_fkey" FOREIGN KEY ("client_cat_id") REFERENCES "client_category"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "defect" ADD CONSTRAINT "defect_client_id_fkey" FOREIGN KEY ("client_id") REFERENCES "client"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "defect" ADD CONSTRAINT "defect_agent_id_fkey" FOREIGN KEY ("agent_id") REFERENCES "agent"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "defect" ADD CONSTRAINT "defect_city_id_fkey" FOREIGN KEY ("city_id") REFERENCES "territory"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "defect" ADD CONSTRAINT "defect_price_type_id_fkey" FOREIGN KEY ("price_type_id") REFERENCES "price_type"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DefectDetail" ADD CONSTRAINT "DefectDetail_order_defect_id_fkey" FOREIGN KEY ("order_defect_id") REFERENCES "Order"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DefectDetail" ADD CONSTRAINT "DefectDetail_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "product"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DefectDetail" ADD CONSTRAINT "DefectDetail_prod_cat_id_fkey" FOREIGN KEY ("prod_cat_id") REFERENCES "product_category"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DiscountManual" ADD CONSTRAINT "DiscountManual_agent_id_fkey" FOREIGN KEY ("agent_id") REFERENCES "agent"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Discount" ADD CONSTRAINT "Discount_price_type_fkey" FOREIGN KEY ("price_type") REFERENCES "price_type"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Discount" ADD CONSTRAINT "Discount_prod_id_fkey" FOREIGN KEY ("prod_id") REFERENCES "product"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Discount" ADD CONSTRAINT "Discount_client_cat_id_fkey" FOREIGN KEY ("client_cat_id") REFERENCES "client_category"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Discount" ADD CONSTRAINT "Discount_currency_id_fkey" FOREIGN KEY ("currency_id") REFERENCES "currency"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "currency" ADD CONSTRAINT "currency_region_id_fkey" FOREIGN KEY ("region_id") REFERENCES "region"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "territory" ADD CONSTRAINT "territory_region_id_fkey" FOREIGN KEY ("region_id") REFERENCES "region"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "visiting" ADD CONSTRAINT "visiting_agent_id_fkey" FOREIGN KEY ("agent_id") REFERENCES "agent"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "visiting" ADD CONSTRAINT "visiting_client_id_fkey" FOREIGN KEY ("client_id") REFERENCES "client"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "cashbox" ADD CONSTRAINT "cashbox_currency_id_fkey" FOREIGN KEY ("currency_id") REFERENCES "currency"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "consumption" ADD CONSTRAINT "consumption_currency_id_fkey" FOREIGN KEY ("currency_id") REFERENCES "currency"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "consumption" ADD CONSTRAINT "consumption_cashbox_id_fkey" FOREIGN KEY ("cashbox_id") REFERENCES "cashbox"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "corrector" ADD CONSTRAINT "corrector_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "product"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "corrector" ADD CONSTRAINT "corrector_store_id_fkey" FOREIGN KEY ("store_id") REFERENCES "store"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "excretion" ADD CONSTRAINT "excretion_store_id_fkey" FOREIGN KEY ("store_id") REFERENCES "store"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "excretion" ADD CONSTRAINT "excretion_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "product"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "excretion" ADD CONSTRAINT "excretion_prod_cat_id_fkey" FOREIGN KEY ("prod_cat_id") REFERENCES "product_category"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "inventory_type" ADD CONSTRAINT "inventory_type_groupId_fkey" FOREIGN KEY ("groupId") REFERENCES "inventory_group"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "knowledge_base" ADD CONSTRAINT "knowledge_base_type_id_fkey" FOREIGN KEY ("type_id") REFERENCES "knowledge_base_type"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "price_type" ADD CONSTRAINT "price_type_valyuta_id_fkey" FOREIGN KEY ("valyuta_id") REFERENCES "payment_method"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "price_type" ADD CONSTRAINT "price_type_currency_id_fkey" FOREIGN KEY ("currency_id") REFERENCES "currency"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "price" ADD CONSTRAINT "price_type_id_fkey" FOREIGN KEY ("type_id") REFERENCES "price_type"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "price" ADD CONSTRAINT "price_currency_id_fkey" FOREIGN KEY ("currency_id") REFERENCES "currency"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "price" ADD CONSTRAINT "price_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "product"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "product" ADD CONSTRAINT "product_prod_cat_id_fkey" FOREIGN KEY ("prod_cat_id") REFERENCES "product_category"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "product" ADD CONSTRAINT "product_unit_id_fkey" FOREIGN KEY ("unit_id") REFERENCES "unit"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "product" ADD CONSTRAINT "product_sub_cat_id_fkey" FOREIGN KEY ("sub_cat_id") REFERENCES "product_sub_category"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "product" ADD CONSTRAINT "product_prod_grp_id_fkey" FOREIGN KEY ("prod_grp_id") REFERENCES "product_group"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "product" ADD CONSTRAINT "product_brand_id_fkey" FOREIGN KEY ("brand_id") REFERENCES "brand"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "product" ADD CONSTRAINT "product_producer_id_fkey" FOREIGN KEY ("producer_id") REFERENCES "producer"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "product" ADD CONSTRAINT "product_segmentId_fkey" FOREIGN KEY ("segmentId") REFERENCES "segment"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "product" ADD CONSTRAINT "product_container_id_fkey" FOREIGN KEY ("container_id") REFERENCES "container"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "product_category" ADD CONSTRAINT "product_category_unit_id_fkey" FOREIGN KEY ("unit_id") REFERENCES "unit"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "product_sub_category" ADD CONSTRAINT "product_sub_category_unit_id_fkey" FOREIGN KEY ("unit_id") REFERENCES "unit"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "product_cat_group" ADD CONSTRAINT "product_cat_group_unit_id_fkey" FOREIGN KEY ("unit_id") REFERENCES "unit"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "product_cat_group" ADD CONSTRAINT "product_cat_group_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "product"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Purchase" ADD CONSTRAINT "Purchase_price_type_id_fkey" FOREIGN KEY ("price_type_id") REFERENCES "price_type"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Purchase" ADD CONSTRAINT "Purchase_store_id_fkey" FOREIGN KEY ("store_id") REFERENCES "store"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PurchaseDetail" ADD CONSTRAINT "PurchaseDetail_purchase_id_fkey" FOREIGN KEY ("purchase_id") REFERENCES "Purchase"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PurchaseDetail" ADD CONSTRAINT "PurchaseDetail_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "product"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PurchaseDetail" ADD CONSTRAINT "PurchaseDetail_prod_cat_id_fkey" FOREIGN KEY ("prod_cat_id") REFERENCES "product_category"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PurchaseDetail" ADD CONSTRAINT "PurchaseDetail_currency_id_fkey" FOREIGN KEY ("currency_id") REFERENCES "currency"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PurchaseRefund" ADD CONSTRAINT "PurchaseRefund_price_type_id_fkey" FOREIGN KEY ("price_type_id") REFERENCES "price_type"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PurchaseRefund" ADD CONSTRAINT "PurchaseRefund_currency_id_fkey" FOREIGN KEY ("currency_id") REFERENCES "currency"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PurchaseRefund" ADD CONSTRAINT "PurchaseRefund_store_id_fkey" FOREIGN KEY ("store_id") REFERENCES "store"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PurchaseRefundDetail" ADD CONSTRAINT "PurchaseRefundDetail_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "product"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PurchaseRefundDetail" ADD CONSTRAINT "PurchaseRefundDetail_prod_cat_id_fkey" FOREIGN KEY ("prod_cat_id") REFERENCES "product_category"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PurchaseRefundDetail" ADD CONSTRAINT "PurchaseRefundDetail_purchase_id_fkey" FOREIGN KEY ("purchase_id") REFERENCES "Purchase"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PurchaseRefundDetail" ADD CONSTRAINT "PurchaseRefundDetail_currency_id_fkey" FOREIGN KEY ("currency_id") REFERENCES "currency"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Replace" ADD CONSTRAINT "Replace_agent_id_fkey" FOREIGN KEY ("agent_id") REFERENCES "agent"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Replace" ADD CONSTRAINT "Replace_expeditor_id_fkey" FOREIGN KEY ("expeditor_id") REFERENCES "expeditor"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Replace" ADD CONSTRAINT "Replace_city_id_fkey" FOREIGN KEY ("city_id") REFERENCES "territory"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Replace" ADD CONSTRAINT "Replace_client_id_fkey" FOREIGN KEY ("client_id") REFERENCES "client"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Replace" ADD CONSTRAINT "Replace_client_cat_id_fkey" FOREIGN KEY ("client_cat_id") REFERENCES "client_category"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Replace" ADD CONSTRAINT "Replace_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "Order"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Replace" ADD CONSTRAINT "Replace_replace_type_fkey" FOREIGN KEY ("replace_type") REFERENCES "replace_type"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Replace" ADD CONSTRAINT "Replace_defect_id_fkey" FOREIGN KEY ("defect_id") REFERENCES "defect"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Replace" ADD CONSTRAINT "Replace_currency_id_fkey" FOREIGN KEY ("currency_id") REFERENCES "currency"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Replace" ADD CONSTRAINT "Replace_price_type_fkey" FOREIGN KEY ("price_type") REFERENCES "price_type"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "replace_detail" ADD CONSTRAINT "replace_detail_prod_cat_id_fkey" FOREIGN KEY ("prod_cat_id") REFERENCES "product_category"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "replace_detail" ADD CONSTRAINT "replace_detail_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "product"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "replace_detail" ADD CONSTRAINT "replace_detail_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "Order"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "replace_detail" ADD CONSTRAINT "replace_detail_replace_id_fkey" FOREIGN KEY ("replace_id") REFERENCES "Replace"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "store_detail" ADD CONSTRAINT "store_detail_store_id_fkey" FOREIGN KEY ("store_id") REFERENCES "store"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "store_detail" ADD CONSTRAINT "store_detail_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "product"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "store_detail" ADD CONSTRAINT "store_detail_prod_cat_id_fkey" FOREIGN KEY ("prod_cat_id") REFERENCES "product_category"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "admin" ADD CONSTRAINT "admin_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "user"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "agent" ADD CONSTRAINT "agent_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "user"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "operator" ADD CONSTRAINT "operator_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "user"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "cashier" ADD CONSTRAINT "cashier_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "user"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "partner" ADD CONSTRAINT "partner_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "user"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "supervisor" ADD CONSTRAINT "supervisor_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "user"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "manager" ADD CONSTRAINT "manager_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "user"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "expeditor" ADD CONSTRAINT "expeditor_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "user"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "merchandiser" ADD CONSTRAINT "merchandiser_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "user"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "warehouseman" ADD CONSTRAINT "warehouseman_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "user"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "warehouse" ADD CONSTRAINT "warehouse_warehouseman_id_fkey" FOREIGN KEY ("warehouseman_id") REFERENCES "warehouseman"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "reciept" ADD CONSTRAINT "reciept_supplier_id_fkey" FOREIGN KEY ("supplier_id") REFERENCES "supplier"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "reciept" ADD CONSTRAINT "reciept_warehouse_id_fkey" FOREIGN KEY ("warehouse_id") REFERENCES "warehouse"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "reciept" ADD CONSTRAINT "reciept_price_type_id_fkey" FOREIGN KEY ("price_type_id") REFERENCES "price_type"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_warehouse_payment_method" ADD CONSTRAINT "_warehouse_payment_method_A_fkey" FOREIGN KEY ("A") REFERENCES "payment_method"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_warehouse_payment_method" ADD CONSTRAINT "_warehouse_payment_method_B_fkey" FOREIGN KEY ("B") REFERENCES "warehouse"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_warehouse_agent" ADD CONSTRAINT "_warehouse_agent_A_fkey" FOREIGN KEY ("A") REFERENCES "agent"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_warehouse_agent" ADD CONSTRAINT "_warehouse_agent_B_fkey" FOREIGN KEY ("B") REFERENCES "warehouse"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_partner_product_categories" ADD CONSTRAINT "_partner_product_categories_A_fkey" FOREIGN KEY ("A") REFERENCES "partner"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_partner_product_categories" ADD CONSTRAINT "_partner_product_categories_B_fkey" FOREIGN KEY ("B") REFERENCES "product_category"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ExpeditorToTerritory" ADD CONSTRAINT "_ExpeditorToTerritory_A_fkey" FOREIGN KEY ("A") REFERENCES "expeditor"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ExpeditorToTerritory" ADD CONSTRAINT "_ExpeditorToTerritory_B_fkey" FOREIGN KEY ("B") REFERENCES "territory"("id") ON DELETE CASCADE ON UPDATE CASCADE;
