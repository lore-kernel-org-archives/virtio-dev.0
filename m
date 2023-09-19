Return-Path: <virtio-dev-return-13816-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0609CD5482
	for <virtio-dev@archiver.kernel.org>; Tue, 19 Sep 2023 07:33:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8B41019231B
	for <virtio-dev@archiver.kernel.org>; Tue, 19 Sep 2023 07:33:00 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 83F4E986679
	for <virtio-dev@archiver.kernel.org>; Tue, 19 Sep 2023 07:33:00 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 7761E9864D2; Tue, 19 Sep 2023 07:33:00 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 648639864C2
	for <virtio-dev@lists.oasis-open.org>; Tue, 19 Sep 2023 07:32:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YfCflYlO5lx/NhkwR0BnoqknepQIYdT26cDnb8BR3T+QCvnS4wrCvcDzxU0l3hef0I8c+80Nw45HWRlf63Af9MFBSvz5a40/TrUe/PrpldLHk6UN6Crkn+SG1CsE2J2VhX5BK+ZpiT0zH/4Jtw9HMH57Kb17PnrFS08LZ9vQobvCa+i0coVsVFKkyNuCwyJPnl9/x2aJlPFPVLn1TRKomSnbO4LsQuGm7KkhoxXi9laYCeyahq4z17EfN/Nj3i1Gq6Xx7VCQjsqPh49h2Ee8zBeXZnnEAqIdzlLXuA900fxu4Xbz1YP6dPwi783ku5UQWFrPdIeP98nocs6cLFjBVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20FRGzSrBagW7kIASZOc8gmWLWzo08lrkTIVbE4WNvM=;
 b=Pxi4F2Qg2mHmMVNZuzLLA1n84epOGUkqgU7mKK615Z2r260+uxB0x2cUgm25GA/pUccOWzJrVkWHhENYuOHNjbWPm+vQOzNCXE6TesqPaiXSWzMjB6jc8eBdieekKXI1dyBkCoziqa4ODkyDOpF+g1mjwbKcoMtFjuxVHquYrztlkfvWbQf3K4IfFdk6u6ztRRYcbgREJzYzda1ynVuRPm6lvpIkx3huNbC2S/OUrKUubWL95fsfOCr1vL6AOOcaOtcgjIiEr3vOxEfFyqpyoJ8KgYtOxJzIJmeEPMaCJIK8GXIFc4lzBonItOLaCA6lvdflnU5YW5JIt1Mpqq8/xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>
CC: "Zhu, Lingshan" <lingshan.zhu@intel.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Michael
 S. Tsirkin" <mst@redhat.com>
Thread-Topic: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and
 vq state
Thread-Index:
 AQHZ540fvvI9R/h+mUufqKbomRy5frAegLUwgAFrbQCAABUsgIAAD5cAgAAA+ACAABKeIIAABNaAgAAAXmCAAWpyAIAAEyeQ
Date: Tue, 19 Sep 2023 07:32:54 +0000
Message-ID:
 <PH0PR12MB54815BB722153D38E8496562DCFAA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <20230914070911-mutt-send-email-mst@kernel.org>
 <559c0875-24b8-0709-712e-24ffe7830022@intel.com>
 <PH0PR12MB548159C982509436C6499279DCF4A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <09045654-d69c-845d-ee26-636fa08f68b4@intel.com>
 <PH0PR12MB5481C41D4F32DA26D5831471DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <67680965-b115-32c7-dfdf-c56ab37bdd81@intel.com>
 <213a0f94-cee2-d8c5-3c5d-d2d7fc920e75@intel.com>
 <PH0PR12MB5481AE8C6E5EAFE9A4ADA6F6DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <f1fe513e-d42d-03a6-348c-5e58aac0a759@intel.com>
 <PH0PR12MB5481323A3B4D67EB66328476DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEvebT7wWUdEamq0u7d2EOrUsjfdyLW4qu2-78UVs7vj1A@mail.gmail.com>
In-Reply-To:
 <CACGkMEvebT7wWUdEamq0u7d2EOrUsjfdyLW4qu2-78UVs7vj1A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SJ0PR12MB6709:EE_
x-ms-office365-filtering-correlation-id: e607e591-ef18-4fb7-fc1d-08dbb8e2a33a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 z9L8bdREjFssBgIjJ1M4OHr8X/Zex8DM0Dg0N7hTmZGMDbnupud2Bqi63hGl9K0nHtz+YdVfYVpHV8NUdUS0/Poa+IueFLrXS+bwWV9LOtLylsXD6+jtxeGQ5XN49LsMjZJhVEkE6SnJhIGtbcXl9iA/wx6jKeZWJmZTqNSR2had0JBglzjfCpkLFoRDNOHh8O/XgayZ/Jq/IlCOd2mBqQPq+sX02rvz1ZXx12q7cWNt/JvAU8wmpO+7b5hM/wSTvQtKltlN0/ESZDKx+a4+ovbguwaILzlSH5XjJtoW6b0xsYQ6lquE0Ts2hgMX/imrNwuBSOdC6Ec+J1Krvzhmd49sJsfEhuqXfIPkxUgaHkvFTTlJno+twiknS7HGgL5h/UfqMORm8qDmwq3ovmEiTowXbf5uf+NSmkVL4cpWZhujAbbS998/Bl7IZPEdXZWXTCMtN6f4Dc3Fmxh8SGsCEnQZ1a4DMN403Mn42MvSvVSPacFhYTeuDr78zooZPS3YDn/7yN7Q80XDc9QuJ22/f8eN/+7z4Fc9rJIYPqdG/LHdddb3INAdj13t5FjbUAExeR1I8yxLvwEOQPNEoOUigaDvQ22rahfFNNn+jRiI08DVSljOvE0nhUHgSVg9HsD6
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(376002)(39860400002)(346002)(451199024)(1800799009)(186009)(38100700002)(122000001)(86362001)(55016003)(38070700005)(33656002)(2906002)(55236004)(7696005)(53546011)(478600001)(6506007)(52536014)(66446008)(8936002)(66476007)(54906003)(76116006)(66946007)(4326008)(66556008)(8676002)(64756008)(83380400001)(9686003)(5660300002)(41300700001)(316002)(6916009)(26005)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cVI3OWYrU2VqVWY2OFgrc2YvM3JBVnVzMXgzWERlb29WUWlxWnVXbU00OFN1?=
 =?utf-8?B?dGtaQXB2MlJDZG5CVHc1Mlh6Qkk5b24ya2JuNkpiRW13dDN1ZzRVeXJhVEM3?=
 =?utf-8?B?YVZZbWtDaGVQcy9XNmpLcEZGeENjV0pmWWJyNUNHV1JPZjFLUndIQ0RFMTBY?=
 =?utf-8?B?U29wa2ZtcGZSZ0FKaWVtd2syOTlJYUI4enBxSkNZaXAvNXh4M3lHVUtMWUtO?=
 =?utf-8?B?NDBBdG9RS2laM0Q0ZUZXbTdvMHlENDdkN1M2a285Q1AyRGFtZVVKUU1uYnF3?=
 =?utf-8?B?ZWk4SFhkbk5GZDRjQzJmNVNicm9pdlZJNEZEQnU5WWVhdXo5Y25hN3dBcU1R?=
 =?utf-8?B?U3Y4SUF2R0EvOWFZNmdhbE1LN2lBL2xUS2cxZkhKRWNZd2J5OFdCbWp0bzBI?=
 =?utf-8?B?V0Y4UlIybFBQK1U1bXV6MU9JV3g0MlI1NDIvRGMxRkRIeW5hVW54RG9DYU4r?=
 =?utf-8?B?akhiaGRmWlZ2d21HMXUycWRwY1FwZUNxcG5TK0ZHMFhMbTNaUXRoM1JOZGV2?=
 =?utf-8?B?UUF1d2pSVzI2R1cyaFFyMjNVSUpnSi9FZHR1KzkxWDE0VSsvM2d2UWFLb1By?=
 =?utf-8?B?b0hmVXRobG1GNFVCVHlwMG9xdFJDWTJxdHUrQlZPN1hyVktFc2Rta0JLdXVm?=
 =?utf-8?B?ZFVhdjJxSldmVURDaTdLaTc2dHVQQTl3V292dU9KTlFMWk1yck1wZ1BGc0FS?=
 =?utf-8?B?Z0txaW1NVHVDRHJGQ0R6cUVpUmRKRTlVenJhczdJS3ZWcDhXdjZud20xQW8x?=
 =?utf-8?B?MTg3U2ZWMlZVcDdhaUpnQ0RReFhlTHdadFgweGNIcVVnSGwvMURnM3NZeHhr?=
 =?utf-8?B?dlRnUVRtQ1FZc2tVTDZ3Qi9WZlc1eHoxbExZK1pCMUVSOWFiM3Vwczl1WVg5?=
 =?utf-8?B?NXV5bXhqc0dqMytPdDAwN3JUR0tuK2ZIbHdmb0h4bXF4UDJwYzlwcmtCZnFD?=
 =?utf-8?B?OUNSbTF6ck03RURtaEJVcDd0aGdxM2tMNTl5RVNmN2JmLzYrd0ZIUTJ3TjBV?=
 =?utf-8?B?dzl6MVRpbmhMK2g5SVFhVVo2cXRlWFEvblRkNVNWaGRPeGN2ZW0zbUN2VkJW?=
 =?utf-8?B?M2tOTFlsWHlrYVZTMU9hNElnL3JsaG11T2Z5RTNlNWZPUVdsZkxNVC9kcmNH?=
 =?utf-8?B?dmNkVXdjR2VuVnBBZ2plemxYUEtpS1RJT1VrRkR0SWhnRGRkb2xFVm11U2tY?=
 =?utf-8?B?WnlnaXNmZmNoajh4ZHp6MG5vZHdybFpIVFF3cEtWTlZvclIzWkg4emhkdlVa?=
 =?utf-8?B?NDdKMXRwdlpyR2xSRklZallobGRTV2I3akRxUm9ZNTRTK05tME5GSkhMUElx?=
 =?utf-8?B?Y3EwWFJ2YW13eUIvaitIRWJvR2dHV2dqVERQbUtZL1FFVlNxQlc3c2hVTWVE?=
 =?utf-8?B?K2tHSDR4aHVPdG9yZVhjV3dLaVRSNE5wV1BzMVRHWDlsQ0s2SzJQL3pjTG1Y?=
 =?utf-8?B?NzZUdHcwdW0yUVlsNG1rR2NNelo4c1hmQ3dValdxUE9tdkNHR3FDSkRTR01G?=
 =?utf-8?B?dHJGZjcySjBMQmpJdFpPTjdwMmV5My8xSXJFNWVmSm1nQU53elBxMndTNTRS?=
 =?utf-8?B?SGxkUU1wb2J2VStOT1RhZWdmaDRBQ0IzQUNjNlFrYWo4OVhiRWo5cDN3Z1lt?=
 =?utf-8?B?YThnSFNHbnJCblZzQlltV2tQUzhFRlVLVjF5SThjWmJBTnhGdHUzN3hsWkxR?=
 =?utf-8?B?Ym1MMEZHc1ZaMXRWWi9ZcUJKTnpoT2FBbk01dk9rNnQwUHpkbis0R0R1Ukdr?=
 =?utf-8?B?YW5qOWZoRlBoU1pNNzdtUWc0WmVPNkFQUTJpeSthVjVPblVkSVFGc1NQNHUz?=
 =?utf-8?B?RGxDclFBbVFrNFcvd3RQbVFUVDZDLzJnOWQ3TE1BNGs3RXJEV2xsQVlNT2Vo?=
 =?utf-8?B?MmxoV1AyWXQrYVo1ZkY0ZUwwKzRuVi8zY1hlaTJ4dld0MHVUaGxjQS9zRG5X?=
 =?utf-8?B?SUVHeXkvdDl0c05qelozK01LTHVGbDlXTTA5ZmhqeXhBYnFMZFhNRTNZSXN0?=
 =?utf-8?B?VzloUEdLenEwUklpLzJiYlpmUkRKSUNUNldZc2dmdXhmcGxVNVNENlhDZW9j?=
 =?utf-8?B?aGRPakRSYjZzWHFObkdPd3AzUUZ4YlhDWU1INXJrUFJqdkpQZm93Z0s0WVNI?=
 =?utf-8?Q?w4S4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e607e591-ef18-4fb7-fc1d-08dbb8e2a33a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 07:32:54.3344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MbHAXqWDFxC5sCW9yQbrdU+r2vzFw/nEiNlwFeXHGkShBmYlV+Nz9ccejp2y3Pos1V61VovfHPnDM890P4iocQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6709
Subject: RE: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq
 state

DQo+IEZyb206IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFR1ZXNk
YXksIFNlcHRlbWJlciAxOSwgMjAyMyA5OjU4IEFNDQo+IA0KPiBPbiBNb24sIFNlcCAxOCwgMjAy
MyBhdCAyOjU14oCvUE0gUGFyYXYgUGFuZGl0IDxwYXJhdkBudmlkaWEuY29tPiB3cm90ZToNCj4g
Pg0KPiA+ID4gRnJvbTogWmh1LCBMaW5nc2hhbiA8bGluZ3NoYW4uemh1QGludGVsLmNvbT4NCj4g
PiA+IFNlbnQ6IE1vbmRheSwgU2VwdGVtYmVyIDE4LCAyMDIzIDEyOjE5IFBNDQo+ID4NCj4gPg0K
PiA+ID4gc28gYWRtaW4gdnEgYmFzZWQgTE0gc29sdXRpb24gY2FuIGJlIGEgc2lkZSBjaGFubmVs
IGF0dGFja2luZw0KPiA+ID4gc3VyZmFjZQ0KPiA+IEl0IHdpbGwgYmUgcGFydCBvZiB0aGUgRFNN
IHdoZW5ldmVyIGl0IHdpbGwgYmUgdXNlZCBpbiBmdXR1cmUuDQo+ID4gSGVuY2UsIGl0IGlzIG5v
dCBhdHRhY2sgc3VyZmFjZS4NCj4gDQo+IERTTSBpcyBub3QgYSBwYXJ0IG9mIFRWTS4gU28gaXQg
cmVhbGx5IGRlcGVuZHMgb24gd2hhdCBraW5kIG9mIHdvcmsgZGlkIHRoZQ0KPiBhZG1pbiB2aXJ0
cXVldWUgZG8uIEZvciBjb21tYW5kcyB0aGF0IGNhbid0IGJlIHNlbGYtY29udGFpbmVkIGxpa2UN
Cj4gcHJvdmlzaW9uaW5nLCBpdCBpcyBmaW5lLCBzaW5jZSBpdCBpcyBkb25lIGJlZm9yZSB0aGUg
VERJIGFzc2lnbm1lbnQuIEJ1dCBpdCBub3QNCj4gbmVjZXNzYXJpbHkgZm9yIHlvdXIgbWlncmF0
aW9uIHByb3Bvc2FsLiBJdCBzZWVtcyB5b3UndmUgZm91bmQgYW5vdGhlciBjYXNlDQo+IHRoYXQg
c2VsZi1jb250YWluaW5nIGlzIGltcG9ydGFudDoNCj4gYWxsb3dpbmcgdGhlIG93bmVyIHRvIGFj
Y2VzcyB0aGUgbWVtYmVyIGFmdGVyIFRESSBpcyBhdHRhY2hlZCB0byBUVk0gaXMgYSBzaWRlDQo+
IGNoYW5uZWwgYXR0YWNrLg0KDQpUVk0gYW5kIERTTSBzcGVjcyB3aWxsIGJlIGV4dGVuZGVkIGlu
IGZ1dHVyZSB3aGVuIHdlIGdldCB0aGVyZSwgc28gY29yZSBoeXBlcnZpc29yIHdpbGwgbm90IGJl
IGludm9sdmVkLg0KV2l0aCB0cmFwK21lZGlhdGlvbiwgaXQgaXMgaW52b2x2ZWQuDQoNCkxpbmdz
aGFuIHdhbnRlZCB0byB0YWtlIHRoaXMgVERJU1AgZXh0ZW5zaW9uIGluIGZ1dHVyZS4NClNvIGFy
ZSB5b3UgYm90aCBhbGlnbmVkIG9yIG5vdCB5ZXQ/DQo=

