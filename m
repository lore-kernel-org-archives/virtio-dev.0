Return-Path: <virtio-dev-return-13779-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED75CD37B4
	for <virtio-dev@archiver.kernel.org>; Sun, 17 Sep 2023 05:25:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2E93F7B50F
	for <virtio-dev@archiver.kernel.org>; Sun, 17 Sep 2023 05:25:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 23A8C98638E
	for <virtio-dev@archiver.kernel.org>; Sun, 17 Sep 2023 05:25:32 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 1536C983EB8; Sun, 17 Sep 2023 05:25:32 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 035EE9843C1;
	Sun, 17 Sep 2023 05:25:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TLTnw2SsR2pKmweSS4TR6H/O4PelTIYAVajdUCLtgIq8bNSZUneg7kNoBc/C29Ya9U6gu3H+SNrBevyFLlFgHkZ6uhfU+NI7t9Y4SFEulyZYA5IQw+o7PG/eeWGWcDdhcZ0ZcxJ4traHz6Nh6WSCgXR6k4KKV0U0ZsUttqVe4tMH3qj3mNMo55otHU0J7DKhXk0XT0fgD0G5EfZHvwS7MWRmBwbCJr1vaRP02BEBMPEseavVMYoFdnpJ24+SJV7aZsQSiT16fB+cMujHVNMBcelsDu6huo9clMClxh41xHr11q3BewSIBQvblmIao0Gvg6VkUcXI/pPi9yO6e8MifQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNoa4GQn+EtVj+kC/ao+S+Ei5L9c712TFBLwoiL3RRU=;
 b=Ih8MAvtPu6L/pcmgikERBybOtPo1ZB+y1pjYaa4iKuXv3ZP8lZMlLYHnbjXMi+/C/S52Ct9aRyYrylMxB+Mo0RmwFHVvZCDesUs9704HBHeJ5H/8+qlYozUlb7SFVe752uL6ZL95fQBnaWOVIXSoNKwbFlV0nB1GiOyR71MKuJvAlwbvsiSO3KfrVexDfV30ec5cI26cW8qpvcrMkpUSZsYflpgyV2rqsUIxT4PGc8xBnn6nyrOFBOM0Q0tbe37+Lk6ezEgNAb+SPoeuiL7QBhy5lnTrrOWsohOpOeGTSm4pFpruw7RgQB3cZpvXF8PcrNO2/SMEJAfG2rvx2X6AfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>
CC: "Zhu, Lingshan" <lingshan.zhu@intel.com>, "Michael S. Tsirkin"
	<mst@redhat.com>, "eperezma@redhat.com" <eperezma@redhat.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>, "stefanha@redhat.com"
	<stefanha@redhat.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>
Thread-Topic: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE
Thread-Index:
 AQHZ4JzDvq0yIsiJnUeYIlWmAxqqv7AU9yyAgAASRHCAAChCgIAAAkbQgAAFdACAAACHUIAABQ0AgAAAWWCAAArYgIAAAHNwgAANI4CAAABkAIAADHeAgAAlTICAAQzqAIAAIezQgAANVgCAAALLcIAAC5qAgAAEIzCAABbWAIAAAKAAgAAF4bCAAAyxAIABDe5ggAAckgCAAAKaYIAAAoSAgAAEYtCAAXpnAIAE27zw
Date: Sun, 17 Sep 2023 05:25:27 +0000
Message-ID:
 <PH0PR12MB5481F53C9B2FFD5FF5BD4E4ADCF4A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <PH0PR12MB5481E8114A659954251F17DCDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <17514b93-2da4-42b3-a5bf-b96358a7a875@intel.com>
 <PH0PR12MB5481F236858D5CD97EF55732DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <9fabd346-9b6f-a727-3de8-813ec3570772@intel.com>
 <PH0PR12MB5481468378DC1E5491A5427CDCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <2baee870-bf38-5d83-0543-1d0a68f8e651@intel.com>
 <PH0PR12MB5481A26B62962979C19280D2DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <8bd1c228-856a-9454-752d-750997c4f4db@intel.com>
 <4c195683-0eb8-5e92-d97a-217cfa8af760@intel.com>
 <PH0PR12MB5481860AEAD92C74A5BC19F6DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <f132cd22-e2e1-971a-894a-d62aa7ca6334@intel.com>
 <PH0PR12MB5481EF64F3BA3D13C34D016EDCF0A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <2f34daa5-3db3-fd64-550d-86678acbfef4@intel.com>
 <PH0PR12MB5481BB050713B687EDD07FB2DCF0A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <9d9ac82e-8eb9-558e-916a-c327e3c3a996@intel.com>
 <PH0PR12MB54814FAE1D790492C8D660E9DCF0A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEvo1cc7jnPT1ia8=+eOcgHaOhr77ey4p+_qLwq+cCE2vw@mail.gmail.com>
In-Reply-To:
 <CACGkMEvo1cc7jnPT1ia8=+eOcgHaOhr77ey4p+_qLwq+cCE2vw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CH3PR12MB8710:EE_
x-ms-office365-filtering-correlation-id: c858c1fc-951d-4666-10b6-08dbb73e8057
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 aahttXPKY6/FKyMpU92lJNePlNcZlDy2YKlHMxolCl10DqaDNcrTNG6AAlLplmnN1DRlcQBugr9j9F5i0CzSpScGpF50+QZcbedgOEZTF16DHhTQl5VfOHyisp7aq0fmI9amtG9GHrKMc8XHH8pKRC1deoWZ6i4I3zdjT652VNykF9FIjFz45yLsGUPQ7PcftZD4/MaN4lH0l8htKjq30jw4YOq73VuczZABlaZjm8N+2ObfMN9ArlRFhi3SKZvbhCQleeLhweY9ZGIKr4rkiYpzaFJt1/T2bROAJ2VvYkwJp7inFNwU9xHwOlDh4fCzdPZ43V9sjAeGtQP9H4cn04nLP8V8uG2zc7e6PirbqtnnHZstiHLVLo1374aqfC2Q5oQXD/Jd3hzqlZAkWnxfbmG+g5VdfD0AqZmyNeIfpPZXzHmm8Hm2jAsL4dXDR66UU3tOdzLoeDnXbAsySNLrHgTDsWAl1Hz/DuUXXeh49T9h6gSEUCmZWHpr279r+dRacfHGjYCT6x2nfxfXrK0C6NyLX84MjnbmRvHSaSbq7Ld/EEC1QrmCWdbIkZT9lcEBbcWoBrMrGUPBGo+9024F4porVlm1ZqNSX5gJkFSWpmw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(346002)(39860400002)(376002)(1800799009)(186009)(451199024)(4744005)(2906002)(66446008)(64756008)(54906003)(66556008)(66476007)(38070700005)(38100700002)(122000001)(316002)(6916009)(55236004)(6506007)(53546011)(9686003)(478600001)(7696005)(71200400001)(66946007)(76116006)(26005)(52536014)(4326008)(5660300002)(55016003)(33656002)(86362001)(8936002)(41300700001)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RHhSNFV0MytzSnZaWmdpV2JySDR3WHJvQmxRQ0JDUmtoZVhtamwvQ2pYOHBL?=
 =?utf-8?B?ZE1wek9QTUl0UmNjZlNXbHIvZjY0UG4rOTF4L2pHVlZyY2FrSWtBVE5HOUtR?=
 =?utf-8?B?V21nbVJFbWJ0OHREa0tOTUl0SmZHNm5nUjJuMllCb3IwZk5xTURGZ3REd20v?=
 =?utf-8?B?ZnRtWEVtY3hNU01GYnJIb1RvTEF5aXNhbU5McGZhZ045bkErMHVZejJLdzAz?=
 =?utf-8?B?dGdiOXpaV0tNdDNTTENudEFqZG9ndis4RWxLWWNGcWdZcTVYQ0VMTTdVNlht?=
 =?utf-8?B?aGR0eWlURUlaYjhJSVFpbDlSWXBDamNEb2ZxaURReHpiQmI3NmxWeTAxM1NV?=
 =?utf-8?B?RkN4SG92VUxJM3Q3T3NBTTQvNGs0MVlhbmswRVZqbnNiK21yd2VEUHl5ZUVZ?=
 =?utf-8?B?M25UNFliWnd5WjBibHJHSmd1eVhFb29sSEhybnRUd0RmdU1MRTNWMUc5M2hL?=
 =?utf-8?B?VmVMdmJjbVVDRlNBR2hpYUJhYVI2MU1MVnFMamhnWVNhdkJuUEJJbUY1SVQ1?=
 =?utf-8?B?YzZGZjRDbTZHaHA1SzllZGNWc3ErM3pOakVDYUMzZ2kxSnU1R2tDYWZFTzNw?=
 =?utf-8?B?dU1Oc011S21FOVN3dG05UnJwYjNCbUJnOFlrdW1hRThqckIwZk43WFRaVmxa?=
 =?utf-8?B?bDdEVXB1bGorWStoUm15bXlndDJScUJhKzZPeW9Od3ovTWZ0MldmKzZYTis2?=
 =?utf-8?B?ZVd3RVRLNjl5eTg2bTBIK3VRU2hDT1pWUnJyZnNSRFIxUCt3OHBwZDBvQjJo?=
 =?utf-8?B?aDYzOEt0ZEduc25qMUcwUk5BRFAyWnl3NmEwUFVJTUxyQkYyL1huQUhmc3Jm?=
 =?utf-8?B?U3lFWGluS1BPZGpmT1dYaFV0NEpBRnZxN0tKZm81ajRHNnlwT1JoQmkyREEw?=
 =?utf-8?B?Sms1dVdTdVd2UHcwQkJBVllXcm8wOTVKbFAyeXJjb2xSUFVYNEVwOUdhYXpS?=
 =?utf-8?B?M3JXeGsyVDRkUGZwV3FtQWZPa0F2cjJ2aVJyWERwb1ZyRnhHMXk4L2ZkbGhv?=
 =?utf-8?B?TkIyY0pRejdIeEdDWmJqSGNUYkVxYjA2a3RadzlHdjExaHMzZFlLZmt6b0NM?=
 =?utf-8?B?dTJxRnZMNzN4YllZZFNrYTkzeFVObkZoNUF0UEFnUDRwVmtrZERhWVYwb1V0?=
 =?utf-8?B?M3kwRC9tcE5kU1ZnMVFUOFY4dDJoT3VOOE1RUjRwaFBodjhMUzN0a0dNd3BQ?=
 =?utf-8?B?SFRSR21LL0MzdVVJN3Y5OXE5amlQUGwxNjZTQmUzQXRnT2hqMk1DQVltVEFq?=
 =?utf-8?B?dlVxRVhYbXphVTZ5ZUZKbnVtSVdYbDMzTzRKcjhtZjV6eno5N3IxTWFsTUpW?=
 =?utf-8?B?cU9mS2U1MkZVNURaVzZOYUZDTDEwKzQ4SEdFeWFPRzIvSmRHeGtzdVAwdlBR?=
 =?utf-8?B?M3dBRWJhd1R2QmFhYmliSFArck04VHhSRFlzTUE0cXZLQ1NtM3JEc2c0bnp5?=
 =?utf-8?B?OU5wNW1YM0NsVE5sRkRvNk9wbnY2eEUvcyt5OVZaVklMaU5VbHo3MDlTazdo?=
 =?utf-8?B?OUxlZXFnaEt1eDZvUDl3TWpvQ3RBdGhHMDJzOXlqa3NJNDFjZkw3UG1icVE0?=
 =?utf-8?B?UnpkNXhhNWV6QjFCcnhmMUVSYUhZaXJ0ejlwOWxqWnhRZEREYzJuN1BtTWZW?=
 =?utf-8?B?Tll4UVVBSE8vc3paOWgxQmNvOWMvbUtvemhMUjBZLzEwOGE4djRkSWRNcHRS?=
 =?utf-8?B?T3BYZm9POEE1M3JZMzdDaVdIWS9qTXhJVGZqbGt6TW9IMEdGaklxSDJVUUxa?=
 =?utf-8?B?Zm9qSmcvZnJtWFE3ejBXbGp2WVZrYmxUZmhKS1U3aGxNNEhzWTQzaVlFK3dS?=
 =?utf-8?B?cU9MMWhZVVFkb3BxeGhhRUVtR3FOYVRtZVJPVEZnT2R5UFE4S3dmSVVoMkZE?=
 =?utf-8?B?U0plRFgvSk9qblR5QVA2Q0pHaExIR0RIVUpCKzl3SUFjbEZOVmZFdy80Zlk4?=
 =?utf-8?B?MXFCS3RjZGRVVGlQWkNQZ2QraHNVMVFOb0hERTFtbUhFemY5SHNTZFBCRlNn?=
 =?utf-8?B?Q0lmZndlUWZ6ZkltWVJ4UXQ2TERsQjJYL0VOSDZYOWhzR01KSnlKdDYvblRR?=
 =?utf-8?B?emRvZ1MrV0VlSG5QTDE2dGdPQ3Z6WldhUkNJRjFSL1NpdlF0RjFtV01ia1R5?=
 =?utf-8?Q?GV3k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c858c1fc-951d-4666-10b6-08dbb73e8057
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2023 05:25:27.1663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YYY9d2LFUEhsrmk6hHjjLHThneWasZSiMSTfnMo+kAxnVPL7pjV5JMErq/a/niaGg+WwzTBnvimgSi7QjSmYNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8710
Subject: [virtio-dev] RE: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE

DQo+IEZyb206IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFRodXJz
ZGF5LCBTZXB0ZW1iZXIgMTQsIDIwMjMgODo0MSBBTQ0KPiANCj4gT24gV2VkLCBTZXAgMTMsIDIw
MjMgYXQgMTI6MzfigK9QTSBQYXJhdiBQYW5kaXQgPHBhcmF2QG52aWRpYS5jb20+IHdyb3RlOg0K
PiA+DQo+ID4NCj4gPg0KPiA+ID4gRnJvbTogWmh1LCBMaW5nc2hhbiA8bGluZ3NoYW4uemh1QGlu
dGVsLmNvbT4NCj4gPiA+IFNlbnQ6IFdlZG5lc2RheSwgU2VwdGVtYmVyIDEzLCAyMDIzIDk6NTEg
QU0NCj4gPg0KPiA+ID4gd2UgcGxhbiB0byBpbXBsZW1lbnQgYSBzZWxmLWNvbnRhaW4gc29sdXRp
b24NCj4gPiBNYWtlIHN1cmUgdGhhdCB3b3JrcyB3aXRoIGRldmljZSByZXNldCBhbmQgRkxSLg0K
PiANCj4gV2UgZG9uJ3QgbmVlZCB0byBkbyB0aGF0LiBJdCdzIG91dCBvZiB0aGUgc3BlYy4NCj4g
DQpJdCBpcyBub3QuIEZvciB0aGUgUENJIG1lbWJlciBkZXZpY2UsIGl0IG5lZWRzIHRvIHdvcmsg
cmVsaWFibHkuDQpOb3QgZG9pbmcgbWVhbnMgaXQgcmVsaWVzIG9uIHRoZSB0cmFwK2VtdWxhdGlv
biwgaGVuY2UgaXQganVzdCBjYW5ub3QgY29tcGxldGUuDQpBbmQgaXQgaXMgb2sgdG8gbWUuDQpJ
IGp1c3Qgd29udCBjbGFpbSB0aGF0IHRyYXArZW11bGF0aW9uIGlzIF9jb21wbGV0ZV8gbWV0aG9k
Lg0KDQo+ID4gQW5kIGlmIG5vdCwgZXhwbGFpbiB0aGF0IGl0IGlzIGZvciBtZWRpYXRpb24gbW9k
ZSByZWxhdGVkIHRyaWNrcy4NCj4gDQo+IEl0J3Mgbm90IHRoZSB0cmlja3MgYW5kIGFnYWluLCBp
dCdzIG5vdCBtZWRpYXRpb24gYnV0IHRyYXAgYW5kIGVtdWxhdGlvbi4gSXQncyB0aGUNCj4gZnVu
ZGFtZW50YWwgbWV0aG9kb2xvZ3kgdXNlZCBpbiB2aXJ0dWFsaXphdGlvbiwgc28gZG9lcyB0aGUg
dmlydGlvIHNwZWMuDQoNCk5vdCB0aGUgdmlydG8gc3BlYyBvZiAyMDIzIGFuZCBtb3JlIGZvciBu
ZXcgZmVhdHVyZXMuDQpUaGUgYmFzZSBmb3IgdmlydGlvIHNwZWMgMS54IHdhcyAwLjkuNSwgYnV0
IG5vdCB0aGUgUUVNVSBvciBvdGhlciBtZWRpYXRpb24gYmFzZWQgc29mdHdhcmUgQUZBSUsuDQo=

