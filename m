Return-Path: <virtio-dev-return-13903-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44702CD494C
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 04:21:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 92B072B060
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 04:21:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7FFF1986688
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 04:21:30 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 74845983D6F; Thu, 21 Sep 2023 04:21:30 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6698798667C
	for <virtio-dev@lists.oasis-open.org>; Thu, 21 Sep 2023 04:21:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FG1vqMP5s4YDquIZ6W/eLhZs/lhmmHZw80DOV0TtfNJ7sNJlQecD45XJoPdPgXd/YETFRRkdzU1SM2zKHsOwpjBrEfOmadyxeIkjoqc+uwXXkkDer9bgH0GCOc0dWIjdzcKv0V/CP8TAykc3CORkLM8vJpUJYRoEF/k+eLK2WPzg2T/rc6arC/PUmKyXPoTMILphfPpsirN+WgB9kQLeYuSzKMCOjG4KG6Afrg19bb+iKHWA5KJknyL8MJrwd2eMc9hXFC+RozZ6Q/hKiwXjNZ/xfP/mLqk1JMt5FQVyrmgGl3fWsulfXieStdqDfvpjZQ5blqk8+cVpOOWNoOtI7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EFYm01JrzXuHFO/qWdVheKz1jncZaIGSqaZOaiW8qro=;
 b=NYlc65d/MnjQ2//hnPqAywmLE0+EZ6KT0ZU3ctKv+q1ysaqribtto/I0NC1/9H3CPWcFa5Zm2QZpinasxzGpnLlSC8HjycPiX1Qek32Z+JrkraEUMKOReiEWTA5zPLaFMrBZWHa5Quy2EndWKK5NAOoB4FoB5rfd80PCGyB6sxLbg3igvtxS/Kf0FiCSjX34SeQ3FHY0IZecsnss2g7huvgS5pkRJ6TKrcqGCqqT0Fuc94C6mqXCP52M4E902dt23LvtK+zrKHrewJlRpmrA6tS5dsyP53MBarSOSkHwZOCxLu6hN/Z21J/Vbv5iElmshcUw9VCRZHruT0v2xzd7pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
CC: "Zhu, Lingshan" <lingshan.zhu@intel.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Thread-Topic: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and
 vq state
Thread-Index:
 AQHZ540fvvI9R/h+mUufqKbomRy5frAegLUwgAFrbQCAABUsgIAAD5cAgAAA+ACAABKeIIAABNaAgAAAXmCAAC3dgIAAl98QgAADDoCAAk+KgIAAS2wAgAAM9QCAAAwSAIAAChWAgAD3GgCAAA8pwA==
Date: Thu, 21 Sep 2023 04:21:27 +0000
Message-ID:
 <PH0PR12MB54815A4E3ED84A5EEF23AB81DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
References:
 <PH0PR12MB5481AE8C6E5EAFE9A4ADA6F6DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <f1fe513e-d42d-03a6-348c-5e58aac0a759@intel.com>
 <PH0PR12MB5481323A3B4D67EB66328476DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <5f01772f-eb27-bfe0-7f69-b83fbd90dda0@intel.com>
 <PH0PR12MB5481ABF4B9BC2082BC54AB1DDCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230918144312-mutt-send-email-mst@kernel.org>
 <bb402c34-ad07-063a-f4f5-d8c6b3a642c7@intel.com>
 <20230920054836-mutt-send-email-mst@kernel.org>
 <2f67fb85-2238-9c34-a265-b0f97b7ab7e1@intel.com>
 <20230920075243-mutt-send-email-mst@kernel.org>
 <20230920084058-mutt-send-email-mst@kernel.org>
 <CACGkMEueq-0dsv2Qqu7j2R119e-K68J7ocWmcyw+d8e3Q13ckw@mail.gmail.com>
In-Reply-To:
 <CACGkMEueq-0dsv2Qqu7j2R119e-K68J7ocWmcyw+d8e3Q13ckw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MW4PR12MB6684:EE_
x-ms-office365-filtering-correlation-id: 959d0729-3d50-4b3a-e18d-08dbba5a393a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 mTpX4FofrbkE8M/ImcB93QbJtURXPJTnLbqjBED4/FttPCIJlDOSegHw99Uf8EdU6HO5mnqrSmFBJeQGxTHmn5Z9718te2k4xyTQmXe9+IiWrU1NEa4U6buL7zwgvb3qC2e08IvNhlIc75kq4pTN0h1PLPO19YcddzLPqMIEOR+RizKQUjh14OInXTFTNDUjK0chrSJUUCOezysprS7ypAoJ0cw9HTGG58b37KrZDgl0im42EBTLdeGqTDHeuT2YSuv2iw4z2GY1+2tzMFsr/6s2BjSEMUCJ2iR2VypdJGrEOIT2wAegmt/EvDbFv/eEmBT5FBm1uobCk8so4M6yXNiDkBdJsaTYGViokz7D+YQLoe+M19kUVkd2k+eMUDdeEByaLKBCm+uubmlVNGNDcekO03hLf9wHBj55NfpSkWbZPND7k+j4Yx2ymXxPMOo/nv5ANoY7nESGNAYBZc8YXPrr5wZE8wJh4KorVbLSJ9MYCQE2Og8pBhbQTcIS+d0wCyy6QMWvrWMqSUSxUc/eNb0o/D+KG4pbpqED9bewJrkDsOcBVBDo2EExHgADRNlJEpsn4EdbidjMiNKHAyermzEUyq+X/jZhJBn4II97XUS97ekTXEy01VV2kfRIMLckQ+9+PdFbjQHUhjlnsfd6AA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(396003)(376002)(39860400002)(186009)(1800799009)(451199024)(26005)(52536014)(8676002)(8936002)(122000001)(4326008)(33656002)(2906002)(4744005)(5660300002)(55016003)(86362001)(6506007)(7696005)(55236004)(966005)(71200400001)(64756008)(9686003)(54906003)(110136005)(66476007)(478600001)(66946007)(76116006)(66556008)(38070700005)(41300700001)(38100700002)(66446008)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QmtnUnpMTVpuRWM3dGFpNkVvMG16OHVLZWFsY3FFK1RjMDV0Y00zM0xoK1hU?=
 =?utf-8?B?UFc2UVg1NlNBOW15M0xNQkNBOUtGNE5DMnMxMFpDbzNYbk5wdm1HZ3VHNEpo?=
 =?utf-8?B?UTBuR2hqQ2tBTkpGRE1nKzVZMWo0emN6eUwxOFJBVk9nMnNvM1duc2x4ei9a?=
 =?utf-8?B?c0EzVGQ1a3dQbUZuNjY3U1FEQlhFRnhNaHVkRzdYZ3BIdk81SVg4OHBvZ05k?=
 =?utf-8?B?RzZSelBwdTA4S3FvYldNOU1RQ2pNZUlOWjBmSjNySlFCUUN0QVZlN0hpVWxT?=
 =?utf-8?B?RTdzbzBGM2w5eDZxVDFrWGE4d3lEK1V2STFrVnljUEF2Z1VoeDZmbW9yVXdx?=
 =?utf-8?B?V1VrZnUwb1psKzhRK1VxWlNZWk1sdjE5TEowVCtISGVTUkJhR0dxQWlHSjg5?=
 =?utf-8?B?dGhhc1M4ajNYMDUwdi9JYndJWE5lRU9kdDBGV3VoUjV2UkplUW9zRm5VYTJO?=
 =?utf-8?B?TkRwMUVQNFdTc2U5MUxpRHJxSWdnVVcxQlhDbE9ONVFjdlBvRVNzSGgzNWN2?=
 =?utf-8?B?T2F6TnQwcTJVbFlwN3M4STlyaytObC9WL1RzbjBaZzcvZXhEeU9oejQvZjNq?=
 =?utf-8?B?R2NiNmQyQi93ekh5UXhid2c0VE5vek5EYm5XZUp1QWxONVJGeVdYZjJXYmRY?=
 =?utf-8?B?V1AwNnlYY0NHby84bmhlWGVpUy9zMHh3eW9pQkZRV1l5djlLSjNBYkYxRXlI?=
 =?utf-8?B?a1ZJNnNHNGM0d2s1cnZnUjdDSlM4N3Rabm5QRnJsUHJUTlgyWUY2ZjhMVTh3?=
 =?utf-8?B?eFV1M3dTZ1hNQjR1MlNWK204VFQ3d28vc05tdFBZTU5uYjJIRVhYaHZhM0xE?=
 =?utf-8?B?UXdyL21BaFBkckN5aW5tb3d2U2tOaDBmQXpFVlZGdEdUYmNINURSK2dCMUI0?=
 =?utf-8?B?d3QwNmxOL1h5KzBqY1IyYW0xWERQS3JOVU54aTM2ZXdrdk9EZUpINE5rcCtT?=
 =?utf-8?B?MEJ4VXVpMEs4d2ZoY0l6dUJLb2lqNjRzSE5KSW5qSkoxcmxkeC80RnBhL0V6?=
 =?utf-8?B?NitrcDFqbzBXZGFtc0dHRFkrdjBzZ1phak1LaEdqRmsvUzhYSFF3MktZRXF6?=
 =?utf-8?B?ZGtuVmp6MVFreWRRdGNDcm4vVzN5dlNJZmpySk9sMmEvYnhqOTNQTk1IcTk1?=
 =?utf-8?B?NHJBRklpTWIyTG5uZ3hNbzR6NVZxU3ZQNE9VckJ1NU9tZHpmaGVUWCtlZk9j?=
 =?utf-8?B?dkxxV0Jpdzh2TFJBZDBhdS92K0o3UlZuc21ZR0V2cmtjbTEzTXpHeEhlSzBL?=
 =?utf-8?B?WWFIdE5Sc2kyczRQN1REMGRmNU9Yb3BTQ1lFM3AyeTY0YlE2VnhyeDRIWDIv?=
 =?utf-8?B?bWxMaHdVV1MvVGtWcWozc2dkTnVOMHJOYjU0WmVld0NMQjNDeTBPZmdjenB5?=
 =?utf-8?B?WlcxT1dLbFc5dWwxeEJkUWllM2thUVpkWlZ3Nlg4NC84NHNiZGRYZ1h2NlBW?=
 =?utf-8?B?Sm4wSDRpbEs1MUNla2R6TDdLNUdkK1c3WW1EcFVlZEZJdFdXMTJrZHlRNlI1?=
 =?utf-8?B?cmFLaFFEeGZlaHBSZ3dPdENyVmJrcTYxZ2RIbHk3Y2c3elVKWHByY2U2VHU3?=
 =?utf-8?B?d2RXRXYyUmlrd3lQZVJhODFEMmh2TUVhK2lVdGU0ZzV0czRiSWliRTF2dklo?=
 =?utf-8?B?SU5veDVMRE9OOUY2RHczREJTOG1VcSs3TDdwRVpWUlFlU2JpcGtyTjY1NTF5?=
 =?utf-8?B?WW5qSDNSY3p2YVJ1di81emdiSi9keVJJbk80Y1BPbW1JMTBOMTVHcmpZclA4?=
 =?utf-8?B?dzJXUTFpeUZ6ajdHblhPOVhabWlJWXl6ajRYRG5nU2lGRVBtUVpZM25HektH?=
 =?utf-8?B?UVh5ZVYyd3hUamx1K1RNaW53YUxIeHQ1NmlMS0pXRGdjdmt2QXd0Q2oxUjd4?=
 =?utf-8?B?cW11ampleHZoNit1d2tQemUxZTd0OU93bndTMFdTQnB0L3FMZGRiL1Zoa2VB?=
 =?utf-8?B?SUYyNmRCN2ZreUtTdjlJZC9wL2p1UUdNS0NpMnA2Vmo2RXBES2Q5d2Y5a1Jt?=
 =?utf-8?B?a2t4RElVenNWY1dOMFJrNVJmRE9neFdkTXBvTGJmZkRsUHVDNTlPQmU0eUEv?=
 =?utf-8?B?ejlmdm1qbUR3SVJIMUQwbTkyMldFNWZkNU5Xc2xpQitmdmkvQTU4WUVVM0Iz?=
 =?utf-8?Q?oLA4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 959d0729-3d50-4b3a-e18d-08dbba5a393a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 04:21:27.2591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FSznNO+I0RrjG56GPrDSImuYCwJjYdisikSeCDog9MJvpxlFf2p6bOxeSM4Hzh+amK0CLKEIICyU6SC6YTkBTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6684
Subject: RE: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq
 state

DQo+IEZyb206IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFRodXJz
ZGF5LCBTZXB0ZW1iZXIgMjEsIDIwMjMgODo1NiBBTQ0KDQoNCj4gTXkgdW5kZXJzdGFuZGluZyBp
cyBpdCBtaWdodCBiZSBiZXR0ZXIgdGhhdCBlYWNoIHNpZGUgZG8gYSBzdW1tYXJ5IG9mIHRoZSBi
b3RoDQo+IHByb3Bvc2Fscy4NCg0KSSB3aWxsIHN1bW1hcml6ZSBpdCBzb29uIGluIHJlcGx5IHRv
IFsxXS4NClRoYW5rcy4NCg0KWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3ZpcnRpby1jb21t
ZW50LzIwMjMwOTA5MTQyOTExLjUyNDQwNy03LXBhcmF2QG52aWRpYS5jb20vVC8jbWQ5ZmNmYTFi
YTk5NzQ2M2RlOGM3ZmI4YzZkMTc4NmIyMjRiMGJlYWQNCg==

