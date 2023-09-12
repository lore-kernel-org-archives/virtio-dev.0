Return-Path: <virtio-dev-return-13725-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA7FCA0EC3
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 13:36:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4450C94EE2
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 13:36:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3F4DE986669
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 13:36:38 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2FBF59864A8; Tue, 12 Sep 2023 13:36:38 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1F9C89864A4;
	Tue, 12 Sep 2023 13:36:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kB7Uq9Wo6fHuiUh9PDwdazzE0r7/I2xVmESOGtx0dsx959aZNsnmkCAV91OtiL8Hii+q2i7p+kmp6Ck94SE+1+Y7GQqHJEwR5NOy74ni19KG8JiRu9hVr+vumIAtvlVy0F6vFexwOYu0s1DZIFMbIuj1OGpHTjG5A++xOIF6q2aLcU1cJejKIuOhObHjFVdGeKelbOvFa/fRwzbeQvpGf6wnZSNf9CXrYeHsTjF1Y7y5VnB7LZui/x1KDRB2cpL23iRzXIwyWeFUDqlb+6e1BYNc+ds9M42lIQ7mRhKOoqAH8rkG752UWvFb5Je3Cty58vpcUut0uvYpV5uokIkDCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K4aKlgJ86VFDCiFnlSpk1Q7UHss/5tbpLqHFTBBR5xg=;
 b=mWWIOh+BHvyd46kdJy6k/PHTqY387Uyk4eCd1J6RQG1lUyO8+By/aZ6ppcl0+gL8QAX9qpiMsDF3TVVbhaEDCoQsaiUI34Uard0z8QuBiVaiXm7XtuEnZrSSuWms07LptaFlV6ecjyK+tw6Q2Jf9ODF8ZQ8FRyFRMoBpaCVmTmIO6z3HHibJIbMXT1E5HqBrDsdJuNmoIe4mJTMKrMNHiA0luMy10/hH+lhyFGwV7CKAu3bJTpeVApZ7IN16Ni6Owqqq365H8WQkiNmVe03rmnL3ZDWnIHh6ZOrtnojsoRPwWJoAG26bklY2Vz9NajZlMG9dxz4maz951LihvIksLQ==
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
 AQHZ4JzDvq0yIsiJnUeYIlWmAxqqv7AU9yyAgAASRHCAAChCgIAAAkbQgAAFdACAAACHUIAABQ0AgAAAWWCAAArYgIAAAHNwgAANI4CAAABkAIAADHeAgAAlTICAAQzqAIAAIezQgAANVgCAAALLcIAAC5qAgAAEIzCAABbWAIAABGsggAAPgQCAAACMgIAAA6oAgAAAf+CAACnigIAACPBg
Date: Tue, 12 Sep 2023 13:36:31 +0000
Message-ID:
 <PH0PR12MB5481C4A1CF084DDA435CE160DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <2b3e8da1-5cbb-f990-0c1d-c0e894a73486@intel.com>
 <PH0PR12MB5481E8114A659954251F17DCDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <17514b93-2da4-42b3-a5bf-b96358a7a875@intel.com>
 <PH0PR12MB5481F236858D5CD97EF55732DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <9fabd346-9b6f-a727-3de8-813ec3570772@intel.com>
 <PH0PR12MB5481468378DC1E5491A5427CDCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <2baee870-bf38-5d83-0543-1d0a68f8e651@intel.com>
 <PH0PR12MB5481A26B62962979C19280D2DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <8bd1c228-856a-9454-752d-750997c4f4db@intel.com>
 <PH0PR12MB5481036BC22785DC22A394D2DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <4c39bfe6-1acf-6ee7-2a0c-1861fa680eb4@intel.com>
 <PH0PR12MB54815CE0845F866CD8125662DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <b892785d-2850-f5e6-531f-d4934ebc7085@intel.com>
 <PH0PR12MB548132955552FF41EA1B43BEDCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <133d6a2f-026d-e94a-12b1-707bbbd8a51a@intel.com>
In-Reply-To: <133d6a2f-026d-e94a-12b1-707bbbd8a51a@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MN2PR12MB4358:EE_
x-ms-office365-filtering-correlation-id: 858b4af4-946c-4940-e241-08dbb3954639
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 5AKbQP1vzxMu9ge9YEf/1gOknPxEwfd3fOkhUFiSyxV7b9MnPkn8h6dOQ2Yi6NFXHrveftzuEYen/0IoShxBneg9xey+tAfRgRnE34Vu8AHKZW8HKWyEO1/X2VvMQYtehlPkliLD6HEhVF/xq87Rm6nSaMq4edEZl1bGANVjnfwSW9ztNCA6i97HQQSUKjFQW/Ie2U8zfoCbWcIJURgIKNhiIQMqxHNu0zaCqhSe1mIhMheLFis5qTbmMk+hneZmOYYFiNGjLTM88FDxrA8Mfw3Za+l6cYs9B+P2PPq/A2nSMAAl06Wk0dqR+eEi2B4eSj9uvIZZazHbemIsAEWczTyNIlINPHeK78ENfaPEBYdpBfNnq8aqwvdI3KyeNRBg6J1N2A/QQWYNKdWZ6ikprpT10BRfNqcwPvqcF4hF1mNlOC8q8Q7EoAYESNl/sl5JMnVzGANfiayftQoevQMz8+ZWFYKVZHjH9mcElaoiLwtXiGdhR8y9PT0iXrv7LxCmegZW1Z/F+21sH1gh7V4KBzwzsXEk0Wb/MojnnOXR/SEPKLkwMWiTUtNghljbk9XwOA+zAJJIM9tmowaLGQMWsjdbWDz4h0hP38U5QmEyZeSWfmzi7rLgj0uZJJYcoqaA
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(366004)(136003)(396003)(1800799009)(451199024)(186009)(76116006)(110136005)(86362001)(2906002)(55016003)(83380400001)(7696005)(71200400001)(6506007)(26005)(33656002)(558084003)(38100700002)(9686003)(122000001)(478600001)(38070700005)(52536014)(5660300002)(8676002)(8936002)(66556008)(66476007)(4326008)(64756008)(54906003)(66446008)(316002)(66946007)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VGVkU0QxT1hlUHNPb2ZtVXNkeDR6Z2t2eVVRSHdtNGRUcWdRUHp3TGovVkpw?=
 =?utf-8?B?aHhmYkZKM2pzRCtqVi9SejVKMjZPaG5VdnVZdkRadVJzR1FDWjJWR1NTTmVp?=
 =?utf-8?B?a3ovMWQ1ek43NVlKNm9KVmtYdGFwdFEwRUEwYzRIOEFneGpNbVpyeS9OSmFW?=
 =?utf-8?B?ZFhzOHpnL1NLbmpFMDRScmtzRjBpMHl0ZVlvU0pJcVl0QzZQN2JxVGgvRHRi?=
 =?utf-8?B?bklGN1hiNnJhdUx5a1lhMWNDUWQ2OFFnbEN4OEZEb0xIdWpLck92SVJCWm92?=
 =?utf-8?B?ZWY4U2lwbVMvc3p1OTVIbTlnaDFUb3VNaEM2djhYVUMyYU1FekNTZ2JwdVJr?=
 =?utf-8?B?anZHVlNGTDV2dHAwd3dxS3R6UEFNUEdXNzdhMnNhRVovT3l3NFBJcXBTSk10?=
 =?utf-8?B?YllabVJsd2lzM0hsTzl6aUtOUjhnSHZ2cmQrWGQ0cFo4aGFpVXZ0d2llNkl5?=
 =?utf-8?B?V2hKL3czZ1I5NTNZeHVhbGRkdnJHMSsrL0tpMndWVWYxTEI3ZENFUjVlaEt3?=
 =?utf-8?B?akpsUTJlZEZFdGx0OEN4cjdZb1UxWCtoYlpSR25yVjVjRW52UkNjMjJaTTJR?=
 =?utf-8?B?NUkxYmlwbHhUZ2pYZnpMTTdJd3pkZERzbDZNcmI0MFhBZnN0Z3hueFd0aXB1?=
 =?utf-8?B?V0RqblBVd0tTakpoVlVpWmxxajRrblpKcU5vZzlwZ0szUUR1YUt5bHU2TlM1?=
 =?utf-8?B?VHRlSDJ4VFJUN2NQbnVHZWc1MlZTS1lEZzl3dTJ3NnBzKzlkSG1xdVMybGVi?=
 =?utf-8?B?VVFtekdSdThxRjZzTjJIOUltbVE2Mkp6eHJZYnlVblZ3TmFTWHJwUkhJVjRy?=
 =?utf-8?B?TTRNRng3ekVaUERsWTd2LzljSk50bnBqdGllbGkvbGxjZFJkWGZnVzVObi9X?=
 =?utf-8?B?QUZPaExHeWl0U01wVXZMNHBTOHpmUHFaUGI0SkRWSnFMNW0yejNmdlRqWGJn?=
 =?utf-8?B?b0dHREw2NFdmSXZ1dDBRTGpCZHYwdW5lVU5aYmwyTEhiOUlTd0lNdlhzYmNR?=
 =?utf-8?B?UUFlMWZ2K3R0dCttQzBOZzJCTmRYR2VNYkkrcE53OGRZcGY1Nmt1ZGRqVm83?=
 =?utf-8?B?cStEdDB3cCtZRDRscFEwVnlZREhGZ0V3Tjl5dis0VEFDemZkOEtkS2dZeUw4?=
 =?utf-8?B?NnJaa1FyMUNSNEtHaUFoTGZ3b2JuQXN5ZmUxcDV4L1pxbmlydThxNWZuRWw4?=
 =?utf-8?B?ZitUQ0hIWWtJT1dzSmlMZ1ljY1ZYR0NQbTNLVTlsQW0wZ2VtL2lBWGVRWHBY?=
 =?utf-8?B?VWZMZWZvNVVKWHdQcjhMV2ZZNW9DSUVmdGFBNHVKU1llQ0N4KzN0ZXZsaU16?=
 =?utf-8?B?NmdWZmJHcHZwaWM5eVJjNmVDbmhuaHVzYnkvM2h4bkxta0NiN3M0M1J6VlNU?=
 =?utf-8?B?cVBSdVUwa2orVFROeHdmYkVWbU5DdHZwdmZ2WFdPa3Qrc1R0NEp6TU94eG1q?=
 =?utf-8?B?ZkJHV0dzcWplcjNra3loWDhrQjE5WURjODljQTh6eFV0TkwreGpqUWswbG1M?=
 =?utf-8?B?S2xTMThySndoUzByTDNjU1dLYlNucWpLc2lGZ3dyRkF6aExvMzU5QzN5K2Qw?=
 =?utf-8?B?UWJYaXBXdWY1c0VvYjYzbW91RlRzMis1c3R0eThCMysybWgxR2p1alJmTWd0?=
 =?utf-8?B?ZXVIRGNnbVZ2ZkhvUnpFTGlCVk9QTzhBOEUwUzVJSHJEazJ3MksvM01nQ05J?=
 =?utf-8?B?ZXdCRk43TkNnMWt2VU05NjhkeUFya1VibXRyWFFvZFcvZndEU1dMVklCSnRm?=
 =?utf-8?B?TElHbmVESXNrdzllbEJUUkx5ekh0VlBwbit6TStYQ1pITk5nNXdwRE9BZ21M?=
 =?utf-8?B?N3RJdFU0RVRQajZHSnlKdnlHWkJUL2MyejhCZm9jaTZMODdvRlpyOXdKbUR6?=
 =?utf-8?B?ajdQZHdsS2o2RGt2SCt2RE92MSt5SGlJOW1CSVIwdTlmOWJOWjQ2TVoxQ0Ft?=
 =?utf-8?B?d0FORm9mVHp1YSt2emVxYW5zZEQ4VHJqZWRkYXJRSFpaM0NKM08zZVh1M0Vm?=
 =?utf-8?B?QXNWM0tpcjhQYWNYbUNCdG9vZGlyYU1QYVVXWHVaUm5IWnZGMHkrWHR3bmM5?=
 =?utf-8?B?aVVZa0JTRDZLZFphK2NwVHRGNGpuTDFoMm9YY2oxeE5vTitWVWNFWDg1UXh5?=
 =?utf-8?Q?pI7E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 858b4af4-946c-4940-e241-08dbb3954639
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 13:36:31.2448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kOjVNR/fQ5kXWaEPQJeBexOG1hJSP9xQNZwzKAEaWL/ck8HJr4V+xrwn7HU/QmnmBNRPycXfsHXwt2FFbZcgKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4358
Subject: [virtio-dev] RE: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE

DQo+IEZyb206IFpodSwgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+DQo+IFNlbnQ6
IFR1ZXNkYXksIFNlcHRlbWJlciAxMiwgMjAyMyA2OjM0IFBNDQoNCg0KPiA+IEFzIEkgYXNrZWQg
ZmV3IHRpbWVzIGJlZm9yZSwgaWYgeW91IGhhdmUgc29sdmVkIHRoaXMsIEkgYW0gdmVyeSBpbnRl
cmVzdGVkIHRvDQo+IGxlYXJuIG1vcmUgYWJvdXQgaXQuDQo+IFBsZWFzZSByZWFkIHRoZSBzZXJp
ZXMNCkFzIEkgcHJvbWlzZWQgYWxyZWFkeSBJIHdpbGwgcmVhZCBvbiA5LzEzLg0K

