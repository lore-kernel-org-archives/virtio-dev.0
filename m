Return-Path: <virtio-dev-return-13708-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 317A4CA0EC3
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 09:36:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A63A77B0B3
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 09:36:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A006C986661
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 09:36:04 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8F2639865CE; Tue, 12 Sep 2023 09:36:04 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7EC2698648C;
	Tue, 12 Sep 2023 09:36:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N+Gtaz21YFqtcoksgvdAvrxACDuXFlyCU9pJN9It5Uo40UYmUWRRWGW+NyoiN6THM471rdFYp/bFOxmRTaRmGtMw0r/0D/a1u9xoIcze6YM1/3i4wXbD/bnDdcC6uJKkx6rmy86OMnu/1cNgRvsIfL4NsvwaeX6H62gopcGweiN52TVPkmL4JbJAqbMZohpi2zFvNvIe2g1VPa57a+3e3y7rqIsTNdW3kQp0V73zUC/ELxwLNL7EcBDbREQVZ/XiUWZ+grPDYXS6S3kD07W7MXmsSbdCFJBpGpKdmuLsWAiuoNSj5p8fqntmfItkZTKwjIYkWJ6d97Q/PN7lj+Qpew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B33xIOVpGxtClM+AVOEkMCiMUeW/Z8Y6Moh2NATRiWY=;
 b=HoM3QmHs18ZIsOd4VacWkTtKlI4v36uA8vjD6olmM6WStNt4cx2k1MMcsKMEiOzVe/NUl462bYD6KJGFRxYWQEs+Is1jV24t8Z+pWcbIvSl6MH2UAvGuSkxUNL5nNX0pfZKrb9P3KTUCrrT0d5eT/m1Nxg/4JderspTdmdKn/CWLNL+s0LUuRRZ0tCKfuPtB6syb7Y6hXZt/+wDhzie/zD+mYuggZJoz8wj2wjQBROwNT+c+oH/ZTVIFfz+9lsrwXfrfN09liJtgDWid9E6BW8Qk6VsiV076aPkLTk0P9Hly772UyiJIiBcHETVLixs+Un91G9yiiBmlXdLT+/K2CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>, Jason Wang <jasowang@redhat.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, "eperezma@redhat.com"
	<eperezma@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Thread-Topic: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE
Thread-Index:
 AQHZ4JzDvq0yIsiJnUeYIlWmAxqqv7AU9yyAgAASRHCAAChCgIAAAkbQgAAFdACAAACHUIAABQ0AgAAAWWCAAArYgIAAAHNwgAANI4CAAABkAIAADHeAgAAlTICAAQzqAIAAIezQgAANVgCAAALLcIAAC5qAgAAEIzCAABbWAIAAAKAAgAAF4bA=
Date: Tue, 12 Sep 2023 09:35:59 +0000
Message-ID:
 <PH0PR12MB5481860AEAD92C74A5BC19F6DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <PH0PR12MB54819C4A4220712DCD57AD56DCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <fff7720f-6019-bd87-b14b-c0bf996f3959@intel.com>
 <PH0PR12MB5481D11A7DF45292103D9290DCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <88b8b14c-88d8-1f76-0e6e-7b5f334171f1@intel.com>
 <PH0PR12MB5481CBE0CDFF4ACD712F371CDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <2b3e8da1-5cbb-f990-0c1d-c0e894a73486@intel.com>
 <PH0PR12MB5481E8114A659954251F17DCDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <17514b93-2da4-42b3-a5bf-b96358a7a875@intel.com>
 <PH0PR12MB5481F236858D5CD97EF55732DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <9fabd346-9b6f-a727-3de8-813ec3570772@intel.com>
 <PH0PR12MB5481468378DC1E5491A5427CDCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <2baee870-bf38-5d83-0543-1d0a68f8e651@intel.com>
 <PH0PR12MB5481A26B62962979C19280D2DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <8bd1c228-856a-9454-752d-750997c4f4db@intel.com>
 <4c195683-0eb8-5e92-d97a-217cfa8af760@intel.com>
In-Reply-To: <4c195683-0eb8-5e92-d97a-217cfa8af760@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|BL1PR12MB5706:EE_
x-ms-office365-filtering-correlation-id: ad2721e4-2d60-49ef-bceb-08dbb373ac23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 wTpH7UEphP1/yyG9sl/ziwXKSuZr8nkUvawfpRKuWSOkGw21oiv3pPUUWZE2rTv5/+zQMJvNCG0eItkc8wjt4SvZCOTlJmO2VfOtgYuSSzm6BXIsnC98WAwnw2uRfoiClz+0HeeTGBVSCxMhh6HsxJaWJS67LJD4+Kq4S56tfkWglhbkwTDA/vhiUZO/ny3obpF4mE+I9CPXk4wtHJW9mUy1yDeU/bn4Rm0yREBg0SEJwHyHAYuV9jjf1LQ4s6Cg35A6r8TTzWYLeRqLXyS5kEt9Nrsp4lS5qnY4A9H4aOkmRUq7IJNSoAM8gc1sOuEQnpymnqYEtUga+44htR7pqA5R01eZgIQM+l1pK383dm4G6IHC7MVuQ/7L4r6l9GGT6kPgIep0s6Aq216YGjJj9C1ZD11oFACVp61lTbkI22AHmejqcjPihLBTBvpH7sGskfOKx+bunXvH5qOUjjlM9SXR3AdjScjm90Uq0eATqRa7uWg/Y3sY6bpD+HpPvga2QIw0IkgDMSzdrnJI3LF2Y4Pyou3bDbaog0GfnpNUL+wlgapIPDR00jPYxMxEaUWHxGsk0MPHVr9mVIGlYdVZcQZSoBmf5vb29dVlBoBRcAtnEoS7jj3+GVwoeJzIWSLK
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(39860400002)(376002)(1800799009)(186009)(451199024)(26005)(6506007)(7696005)(9686003)(122000001)(38100700002)(33656002)(38070700005)(86362001)(83380400001)(55016003)(478600001)(110136005)(66446008)(76116006)(66556008)(66946007)(316002)(54906003)(64756008)(66476007)(52536014)(4326008)(8676002)(71200400001)(5660300002)(2906002)(8936002)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cHo5MDFPeFZ1elo3Z0drMVJLZ3hHUmh2TmRFcEwrcDhYYUVETmJuMHc2MUha?=
 =?utf-8?B?SnlMam1HcHlyS1FiRTB5SjRiRlBFSDIzbjgxQnZ4d2JQaXFHVjNMWWhCRnRm?=
 =?utf-8?B?dHVneG1Vd1N5S3R6NDNkVm82MHFPWktORlRnaXpoUEMvMmFxNlF3R2RDQkVn?=
 =?utf-8?B?SE5zWWk1dlJKRDNPa05zN01Iclpid1I0a0RvSFpDZ2tLZHBrM21jSXVLQ3ZE?=
 =?utf-8?B?aUZ6SnJCTUhvZUQ5ZnlpZW1DWUJaeG5lNXJqNkFwR1E1NDllMTM3Wkh4Yllj?=
 =?utf-8?B?RVd5YmNzdGRGb1BRMkNRanNDTkRrTTc2ejJ4Wkp6RmNQL2g1YUdZTjRMK29B?=
 =?utf-8?B?UlVsMVU5bEJMSmlvK1RJNWI5U0tmeFB5aC84MVNjS1AyVHNMaTk3QWRlNldL?=
 =?utf-8?B?dXlrcmJQWVBaREFMeFBSMXBYTTArZlJMSUl4RkVLdStlMTFvQkQ4eFZJdTVs?=
 =?utf-8?B?a0lWMHltcDNjZVkxcUR3V2xxdWpmWlFJRzc5aFlFUUU2emRoMjZwVTFjQlU3?=
 =?utf-8?B?ZS9XTXp3ZVB1a2JOSjJ6Y0p2Q1NpNGMweTRrSDVlWTlXSUtpa1N3azFXWVFI?=
 =?utf-8?B?aS9lNTR4c1hEV1JIQkdEbnNaczFxYU9wSndHT1JobnJzT3pEWDU0S3dpQVVk?=
 =?utf-8?B?OVRlUS9iajVvZmJ6bVZZMWFvKzlqVmpSakhSZW5CMzk3YnZEUFlvNkovVExF?=
 =?utf-8?B?OStNZjZoMzhYdDJmOTlJMmViWWV5MDlUOEc4NU1zR0lXTFBpVzRtSjlaOExp?=
 =?utf-8?B?NURYQU5KVlQ5c0xQUkhhdm9jbXA4UU9GN01xMVV6MXJVOXpBdkx5UnA5VlpS?=
 =?utf-8?B?cForSXBlT0Iwd1kwQXY5RUFDZllWZFpidGEvV280SCtKR1BTL1dSbGNjT2x2?=
 =?utf-8?B?dldRWFpGb21tVC9DSGQxck5hRE9JSkNtK2lsYkd0OEh2OUdXeHRwbDVSZThE?=
 =?utf-8?B?UFNNR3V6ZldsQ3A3VE91T3JzNnRiSmtkd01zQXBQRitMTTBHWWpVb1c4SVdF?=
 =?utf-8?B?THMwazVuWit1UGVOSWtoWnpoRzFEWVR3RnlxWGl0Q1hlbGVBS0ZOekVxYjZn?=
 =?utf-8?B?V1JhSjRJdW9tWjB5N2ZsQmtibnVFZmdZNHlHVlZaT2kvM2NTTGVCdEVsNjVE?=
 =?utf-8?B?U1VOVXNvaFAxRXpnVS9NcFRuY1ZWRFpORytHaStadTM0TllNa2MxeEQ3S1lP?=
 =?utf-8?B?SFROcTg5QTdoYzVVZy95UlZnNmVTVmZPN0VKenI0RGgydGV5QkxyRWRGTEVW?=
 =?utf-8?B?ZE9aTEhnNHVnZk1DckpyYzVpaHg4NWRwY2VnTy9UVS9oMnBmbUNiVENPTWJR?=
 =?utf-8?B?cUV4KzVhSmtmQTFrM0RFQUludkJteHQ0UCthUm9HYXFvUElJMmIxNTN0TXN1?=
 =?utf-8?B?SyszbHBjWDNmNk5VTWcyMXcrQ0JmaVRFNkxlYVpwMDd2R0hNQWxPNGdnZ05Q?=
 =?utf-8?B?UkNDbitGWmxkejRzNXJwdGdtR01jcVA0NytCUHlqeU9vMzZqRi9qeGlyc29u?=
 =?utf-8?B?SWhrSWY4WXZrcmNaeUFLRGRMRjU4SGR5cEtLc01GUUZjditIU0MxL256UnNz?=
 =?utf-8?B?bk9OMWRkUzJkc1hSeGQydlEzZ3BOdmMxQ1RRRk9VZDlZNWZ0aFhFbjFuOVU2?=
 =?utf-8?B?SjJqRmx6bFpvUlF2TTlpaW5RREZWSzNCRnYxN0tEM1dSODZjMVFZUE50WHJD?=
 =?utf-8?B?MjViTVRybysrNVNxVHcyMEY2aXdWQ3lnQkNVL0NEZjJOUnhKQldVeU12aGFm?=
 =?utf-8?B?bFV5OEJFaWxxZndVeXo3Ujd1RmhEd0lGbjJyREhLVzJjYnFtbE5pRWVGSTN1?=
 =?utf-8?B?TmxoZUNXc0NEbWJXSTVwRHk2bUtrSjlYbGlMY2lqVURhWUNtN0gwS0k0eWxZ?=
 =?utf-8?B?QlJFa2xmVUtsd1lENzVRTy84Sm1nTEFWTDdWQS8zOFZ0aG96cDFySDNRb1FQ?=
 =?utf-8?B?bGdic0tOd0hkVnl5MmpwMTVQMkw4WWJnQ3d5QWE1YXVLSlU3eVM1VVB4YmxB?=
 =?utf-8?B?MU5WNjNvT0llV2orL3lKMVY5cmsyQ3pjMm1sdXdjWXp0RFR2TjBlclJEdzJ4?=
 =?utf-8?B?MXg2OFdxSXZXeEZFL1VjUS9tNGJKMkVkR0o2Y0VRTHJIOXF3NmE5UFBTUmlt?=
 =?utf-8?Q?bfmk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad2721e4-2d60-49ef-bceb-08dbb373ac23
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 09:35:59.3422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tWrKAaRTCe4f2t2H47WeLQ83tc4u+s8F+86G+EuCuuYNmP/Rq9ukiDQeZy6Xq1rY7nJDkHpwmBeSMHxJPqSvnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5706
Subject: [virtio-dev] RE: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE

DQoNCj4gRnJvbTogWmh1LCBMaW5nc2hhbiA8bGluZ3NoYW4uemh1QGludGVsLmNvbT4NCj4gU2Vu
dDogVHVlc2RheSwgU2VwdGVtYmVyIDEyLCAyMDIzIDI6MzggUE0NCg0KPiBzdXBwbGVtZW50YXJ5
OiBBcyBKYXNvbiBldmVyIHBvaW50ZWQgb3V0OiB0aGUgdHdvIHNvbHV0aW9uIGNhbiBjby1leGlz
dCBmb3INCj4gc3VyZSwgSSBhbSBpbXBsZW1lbnRpbmcgYmFzaWMgZmFjaWxpdGllcywgYWRtaW4g
dnEgY2FuIGZyZWUgZmVlbCB0byByZXVzZSB0aGVtIGxpa2UNCj4gZm9yd2FyZGluZyBtZXNzYWdl
cyB0byB0aGVtLCBhbmQgdGhpcyBjYW4gaGVscCBzdXBwb3J0IG5lc3RlZC4NCg0KU3VyZS4gU291
bmRzIGdvb2QuDQoNCkF0IGxlc3QgdHdvIGRldmljZSB2ZW5kb3JzICsgb3RoZXIgaW5kdXN0cnkg
Ym9kaWVzIGluY2x1ZGluZyBsZWQgYnkgSW50ZWwgYXJlIG1vdmluZyBhd2F5IGZyb20gdGhlIHJl
Z2lzdGVyLWJhc2VkIGltcGxlbWVudGF0aW9uIGluIHZpcnR1YWxpemF0aW9uIGFyZWEuDQpBbmQg
cmVnaXN0ZXJzIHRoYXQgeW91IGV4cG9zZSBhcmUgbm90IHN1cHBvcnRpbmcgZGV2aWNlIHJlc2V0
IGFuZCBGTFIgc2VxdWVuY2UuIFNvIHBsZWFzZSBhZGQgc29tZSB0ZXh0IGZvciB0aGF0IGluIFBD
SSB0cmFuc3BvcnQgc2VjdGlvbiBhYm91dCB2aW9sYXRpb24uDQpBbmQgZ3VpZGVsaW5lIGZvciBk
cml2ZXIgb24gaG93IGl0IHNob3VsZCBub3QgdG91Y2ggdGhlbSB0byBtYWtlIHRoaXMgdXNhYmxl
Lg0KVGhpcyB3aWxsIG1ha2UgdGhlIG5lc3RlZCBzb2x1dGlvbiBtb3JlIGNsZWFyLg0KDQpEbyB5
b3UgZmluZCB0aGUgYWRtaW5pc3RyYXRpb24gY29tbWFuZHMgd2UgcHJvcG9zZWQgaW4gWzFdIHVz
ZWZ1bCBmb3IgbmVzdGVkIGNhc2U/DQpJZiBub3QsIGJvdGggd2lsbCBsaWtlbHkgZGl2ZXJnZS4N
Cg0KV2Ugd291bGQgbGlrZSB0byBhdm9pZCBzdXNwZW5kaW5nIGluZGl2aWR1YWwgVlFzIGluIHRo
ZSBwYXNzdGhyb3VnaCBjYXNlLCBhcyB0aGluZ3MgYXJlIGNvbnRyb2xsZWQgYXQgdGhlIGRldmlj
ZSBsZXZlbC4NCkl0IGFsc28gcmVkdWNlcyBkcml2ZXIgLT4gZGV2aWNlIGludGVyYWN0aW9uIGZv
ciBsYXJnZSBxdWV1ZSBjb3VudCByYW5naW5nIGZyb20gMSB0byAzMksuDQoNClNvIGF0IHByZXNl
bnQgSSBzZWUgdmVyeSBsaXR0bGUgb3ZlcmxhcCBiZXR3ZWVuIHRoZSB0d28uIEkgd2lsbCBsb29r
IG1vcmUgYWdhaW4gb24gOS8xMyBpZiBwYXNzdGhyb3VnaCBwcm9wb3NhbCBjYW4gdXRpbGl6ZSBh
bnl0aGluZyBmcm9tIHlvdXIgc2VyaWVzLg0KDQoNCg==

