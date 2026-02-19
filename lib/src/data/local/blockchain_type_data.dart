import 'package:senchange/src/domain/NewWalletEntity.dart';

class BlockchainTypeData{
  final blockchains =[{
    "id": "3264b87c-2712-4bda-bd33-00a903363958",
    "code": "TRC20",
    "name": "TRON (TRC20)",
    "is_active": true,
    "display_order": 1,
    "created_at": "2025-12-10T22:31:44.362266+00:00",
    "updated_at": "2026-02-06T18:17:10.685798+00:00"
  },
    {
      "id": "d5b03a22-6213-4e69-8e58-91a427dbf01f",
      "code": "BEP20",
      "name": "BNB Chain (BEP20)",
      "is_active": true,
      "display_order": 3,
      "created_at": "2025-12-10T22:31:44.362266+00:00",
      "updated_at": "2025-12-10T22:31:44.362266+00:00"
    }];

  NewWalletEntity walletEntity = NewWalletEntity(
    "0f46699b-c839-432e-af97-7c1529875d53",
    "825d89fc-6fc7-4696-8969-104841c33d66",
    "W1",
    "0x1e4dea1c6e464e620b287cbcb1372e2a6f7ae5ad",
    "BEP20",
    "USDT",
    true,
  );
}