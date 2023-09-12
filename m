Return-Path: <virtio-dev-return-13710-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0503ACA0EC3
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 10:16:18 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 62633190914
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 10:16:18 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 57E869865B7
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 10:16:18 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4B167986485; Tue, 12 Sep 2023 10:16:18 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3C2B798648C;
	Tue, 12 Sep 2023 10:16:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lh9QMVAlPN4oijIky1aoNtJNQTUIHPEtVfyBSS67n+WRBkD+aW0ij4WPwbjEzQENPdRvN63ANkao6n53SU3j1NCoe7Y+DGDs0ZbxjDvxGcV6J8YZFVmkzBEmh6eNKyVCEj/ssGswpR/mkjCR+33bcjwIoZbWCiUBggEY0u2xwHLqUH3vu7GruD4PV35V8tK+pr7B1nyEnFH+pJx5betoYS5Bn5U1UhqGU/JRnEt2V5N6MqSdchWj3ILYYV7L5SN8d9cEVnZbcrDZCXDWA9IB1NXd/E0isHw6Y/66dZHjFAlBFd5cZJcxj2Cq6KslaUbH0O/kSz5ke9je4YaXBdRlNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+7g9UxZgKOcSfaR/pWh1AbMXQOH9Eyw1NwKTg46ZBco=;
 b=J6EAXebBT6MsZKpK7CZLMFoCmEiQVfh25NypwfPj4yAHDzY0guloPRh1N+ac8f0hFPKqv4intIFgSt1s8+/oA8QQRvoudYgiGz3iGi3PBVMU2gj43m6DM58LTfrPTEn9xTUNN8gTZNE5Qk/EZR2lDK5p0oZV48zbAgz+1i5hjplT9TLzRhG1DVsfGWH38GMXxmgRwKdgVKJzxqFowJD4RbFio18evP7h3mnurRRT/Xkz90OEMru+PQkFMxRyw1tISOs3UsQBO0bmwD24geNDFC71LgnSwcUUv42Dt1FsYNLP5jXRTL1VFArjE1id/NQXyweR9NtZz1YVko7LTCuyWg==
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
 AQHZ4JzDvq0yIsiJnUeYIlWmAxqqv7AU9yyAgAASRHCAAChCgIAAAkbQgAAFdACAAACHUIAABQ0AgAAAWWCAAArYgIAAAHNwgAANI4CAAABkAIAADHeAgAAlTICAAQzqAIAAIezQgAANVgCAAALLcIAAC5qAgAAEIzCAABbWAIAAAKAAgAAF4bCAAAyxAIAAAEHQ
Date: Tue, 12 Sep 2023 10:16:11 +0000
Message-ID:
 <PH0PR12MB54814149C4B25A58074B9F91DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
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
 <PH0PR12MB5481860AEAD92C74A5BC19F6DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <f132cd22-e2e1-971a-894a-d62aa7ca6334@intel.com>
In-Reply-To: <f132cd22-e2e1-971a-894a-d62aa7ca6334@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SA1PR12MB6972:EE_
x-ms-office365-filtering-correlation-id: 9825f618-e514-4dc8-ed57-08dbb3794a29
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 7GYQlxGCEjPDMH6At/bJtTG89QcbU8nU1HpE9tP5uvA5LhLeIlHa9fWYjAdCTQKD/bs4oqVl/s9HKz7qGrebARJfoYIPmn2qw9u92HtI4hSz6Zea8rt/qrbchBYEqA1uD6S5AhARF+I73GxvlQDV4sWtd3df5HkcMtKN4B/geYWRboHUHstvlpVjyqC9ytCo8Fzt4qG336yzo++WdLor8pYAQp2IoH7ENxM+DaWGaRjSF1N4RwklZxrzEs5fCnxmCQBUFBibbqIvbVyzIokXo0zWpkdplBe5JN8G78h+5XE1Tb2tr5c3xSq3MQ8yFZV7m62C+fvT8GKWzbigZLqVqCsMOBDt/LC1HjznwgazEY1FxOGTKZVhI1BByAB3Y9GUaQkATEb6UQG5cKdAIAPk4fmgbqSXeVJuPbZRxPVgYuAe6TA2mzmnUcqP/jIO7dvCn322dyhuADJcRXnoJvEcG0w4WOGxqnOlqGqd0K7WKSF+s+H4+UtR1MH02qy5/HokFEa5xOnPQsKl8WAPbX3G/yp5SIsmkuuzerm9AdCxr+Ubn/fmrvExmz+rtOCgeomdUGEQ+qdl7LgD2aFPg4IAskaf5qtzRaYCgXAre2s9N84h1GdeKZoKfRnHpjsz3881
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(136003)(39860400002)(346002)(451199024)(1800799009)(186009)(41300700001)(122000001)(53546011)(7696005)(6506007)(71200400001)(55016003)(86362001)(38100700002)(33656002)(38070700005)(2906002)(9686003)(83380400001)(52536014)(5660300002)(4326008)(8936002)(316002)(8676002)(66446008)(478600001)(110136005)(26005)(54906003)(66946007)(64756008)(66556008)(66476007)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c1FDdVNzQVNVQkpob3oxVklBdW8rVC93ZWZiSmN2WHFDTXQ3eFBQTjZmSzNM?=
 =?utf-8?B?UnBqMkdFK1hrSUdVNVdjK1J3TGE3ZnBEVHNsclhwN0ZCcmdTMTJSNHdGaFFQ?=
 =?utf-8?B?L0lBSzJhSitBS3BFYWo3WlRlS0tYWEw4ajNiSm1Jc3VkckhFSjhDRHZSSThK?=
 =?utf-8?B?TWlqbUV0U3E3Q0lKMTRXejVmYWVyK3Btd0FuTVZ1K0dpSGs3SzljRzJINVBF?=
 =?utf-8?B?K1QxRU5zeEpncmpFeXAvbkk5YXo5SXVvUjk1THVZbHpIZXZhQ212OEM0RFBS?=
 =?utf-8?B?TWY2R2QwZjFGM3FhY3lSK3BxQnRxN00yQkxSWXB2QXloV2xWaUl6YTJtTFhs?=
 =?utf-8?B?dy9GYVAzcThpWGtrRms3dFFXa1ZxcjE1YzQyVHhMSSs2VTVHUXhVeTZLZyt2?=
 =?utf-8?B?TTBOdkdMZnJ3UGR4UExBeUpsRmU1TFoyd2g0S1JMbzhTNDNNbDRKMk1xbW9x?=
 =?utf-8?B?QjJoTXhqTDF2bUlqV2lOeWdmaUU3eHZyZndRUzlwN2IzdjRTcjBTMkNtbTJs?=
 =?utf-8?B?cmNzSzE3ZndjNFhKenNkTmdjVEY5VHlDU3JNQWJaOEN4QWF5U29WN0xCOWpL?=
 =?utf-8?B?MEZ3a2trZUZqYi80TG9lNWlTb2VJVktIaUZlZkV3VCtHbFpXZTNUMG91V1h1?=
 =?utf-8?B?cTczeGlXcnZVVWtEWjBBODk1TlczblNBc3NkU1I5VWNDN1BQei9DbmdNckRi?=
 =?utf-8?B?VW1xeC9adzcyM21UcVNCWlZoNy8wemdZcW9mcFZ2dmNJc1dLRGVhUGYrd3dI?=
 =?utf-8?B?M1RCVlRRVjVrMjdlekRDWUs3M1ZSZ0lZSElLc2N5eEVwRTV2bmpLTTZNa0NM?=
 =?utf-8?B?L0Y4TVpGQVA0K2p0ZHNTaElnWlRiNjk3YWpNK292cjRQOU9KMHNSSlA0NGh5?=
 =?utf-8?B?eGtIZisrZXJKR2dzM0kwVFVtTlFQTmxocDZ1RTVzVWpaSWpqTmxPUmxqTWlE?=
 =?utf-8?B?eWt5UHJ4UGphc3BkRUlkQktwa3JTUXZtK3hKQVpoMThuNUVNVkFsQW9xOWhu?=
 =?utf-8?B?R2ZmU2ZORkxIR0JpbzBTQjdqd0I5WUUwMUMyUUh4aDRuYkQyWUdDbGdPa3Nq?=
 =?utf-8?B?NnhpUlZnV2l5d0ZVZDlVaDNuSm5sb3B0LzRUYVgrSnJlMEVlKzdTOTZTMDdy?=
 =?utf-8?B?Mk85VnEvQWZjbXNCRThGblorZUdtVVU5dlNKUW5uanhzUXZTUElTUWxaOVpI?=
 =?utf-8?B?TEhhUkNVMjlubWhNUlBmZktIVnE3UlpBU2JESXVIRGFnRFdIaHJZc2hCVElX?=
 =?utf-8?B?SGM2Um9hRFZvQk1pNStxV1hpTWVCTzFDWWZkWC9NUk5LMllhVk0xRzFkdkI4?=
 =?utf-8?B?SWxPOGJRZzZMOWIyME5KS0ZFTWJLQU9IMUdMNDV1R3FLcWRVS3ZRdTRydENB?=
 =?utf-8?B?NjhDdkNQdWRPZ01WNXVHUXhTckFEM0hDc1JDZG5tb1NPaUFoS3hTanJXUDBq?=
 =?utf-8?B?Y2xQcDVybkt1eTJObWgwUERYUUFoTXpTYlB6c0JRYjZMUjJIcHUvelNWMEYv?=
 =?utf-8?B?MXhzcWJCL2xUazhpU1BjMXB1MEgrcS9HTXhZQ2lnc3NnQTd0TU1lY25YajZ5?=
 =?utf-8?B?U2R2U1lrd2tWUDdLSkM5M3VMZFJCM3NvcjZkWHNxM01GVnJBMEpGLys2NTA1?=
 =?utf-8?B?Ty92OVJtNEJSV2hJUndCOGg0Z0h5d1RWdjI0aW1kN25hZXp3VTBBTjhmQitw?=
 =?utf-8?B?MG9SM3VBNExEMHFDaHRHb25NR0NTaGdPUzlwaGJhMXhoaE9JUVJxeEpzQ0x0?=
 =?utf-8?B?Yis3MkRNQ1lhVFlwREx4VWhTeFdPZEcvUld1bXB2bmY0RWdjUjRFQ3RtTUd6?=
 =?utf-8?B?dFZ5cEtqdVFRRXJxVHhRYnlwYm16dzZCbFQ3ZVZiZmxxcWJlTmdmdjBTSjFq?=
 =?utf-8?B?NUg0blc5UmVyNmxFMFVuOWozV2lxSVJFMUR2L3BWK0hDcjgrNklNY1JDQ083?=
 =?utf-8?B?RXp0dkF6cEd1aGxvcjM1a2xGT2tXZ09Ka1UvNlFOZWlZTWorbVhiek9jWnNu?=
 =?utf-8?B?Q2RPWXh2SjV1VnhkMVVGQk5yRm1lVDJqQ0UxdDFzSklJYWVwTWRBYVkweEts?=
 =?utf-8?B?OXYxWi9KV0JiS2duWGlQUjhuRjRGdkE0bnhPSHNFZTMxNVVrLzlTaS92Ny9R?=
 =?utf-8?Q?RFh4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9825f618-e514-4dc8-ed57-08dbb3794a29
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 10:16:11.9134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tpRU2F8mBh7T/BSVlwSOC633Z08UUclObOKkiu8ZJySRrhHzUSoA95JkmCLX5tZO9t2JJRcNo5dMqx3dSUDGqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6972
Subject: [virtio-dev] RE: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE

DQo+IEZyb206IFpodSwgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+DQo+IFNlbnQ6
IFR1ZXNkYXksIFNlcHRlbWJlciAxMiwgMjAyMyAzOjQ1IFBNDQo+IA0KPiBPbiA5LzEyLzIwMjMg
NTozNSBQTSwgUGFyYXYgUGFuZGl0IHdyb3RlOg0KPiA+DQo+ID4+IEZyb206IFpodSwgTGluZ3No
YW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+DQo+ID4+IFNlbnQ6IFR1ZXNkYXksIFNlcHRlbWJl
ciAxMiwgMjAyMyAyOjM4IFBNDQo+ID4+IHN1cHBsZW1lbnRhcnk6IEFzIEphc29uIGV2ZXIgcG9p
bnRlZCBvdXQ6IHRoZSB0d28gc29sdXRpb24gY2FuDQo+ID4+IGNvLWV4aXN0IGZvciBzdXJlLCBJ
IGFtIGltcGxlbWVudGluZyBiYXNpYyBmYWNpbGl0aWVzLCBhZG1pbiB2cSBjYW4NCj4gPj4gZnJl
ZSBmZWVsIHRvIHJldXNlIHRoZW0gbGlrZSBmb3J3YXJkaW5nIG1lc3NhZ2VzIHRvIHRoZW0sIGFu
ZCB0aGlzIGNhbiBoZWxwDQo+IHN1cHBvcnQgbmVzdGVkLg0KPiA+IFN1cmUuIFNvdW5kcyBnb29k
Lg0KPiA+DQo+ID4gQXQgbGVzdCB0d28gZGV2aWNlIHZlbmRvcnMgKyBvdGhlciBpbmR1c3RyeSBi
b2RpZXMgaW5jbHVkaW5nIGxlZCBieSBJbnRlbCBhcmUNCj4gbW92aW5nIGF3YXkgZnJvbSB0aGUg
cmVnaXN0ZXItYmFzZWQgaW1wbGVtZW50YXRpb24gaW4gdmlydHVhbGl6YXRpb24gYXJlYS4NCj4g
VGhpcyBzZXJpZXMgaXMgc2VsZi1jb250YWluZWQsIGl0IGlzIGFuIHJlZ2lzdGVyIGJhc2VkIHNv
bHV0aW9uLiBJdCBpbnRyb2R1Y2VzIGJhc2ljDQo+IGZhY2lsaXRpZXMsIGRvZXNuJ3QgZGVwZW5k
IG9uIG90aGVycyBsaWtlIEFRLg0KPiA+IEFuZCByZWdpc3RlcnMgdGhhdCB5b3UgZXhwb3NlIGFy
ZSBub3Qgc3VwcG9ydGluZyBkZXZpY2UgcmVzZXQgYW5kIEZMUg0KPiBzZXF1ZW5jZS4gU28gcGxl
YXNlIGFkZCBzb21lIHRleHQgZm9yIHRoYXQgaW4gUENJIHRyYW5zcG9ydCBzZWN0aW9uIGFib3V0
DQo+IHZpb2xhdGlvbi4NCj4gPiBBbmQgZ3VpZGVsaW5lIGZvciBkcml2ZXIgb24gaG93IGl0IHNo
b3VsZCBub3QgdG91Y2ggdGhlbSB0byBtYWtlIHRoaXMgdXNhYmxlLg0KPiA+IFRoaXMgd2lsbCBt
YWtlIHRoZSBuZXN0ZWQgc29sdXRpb24gbW9yZSBjbGVhci4NCj4gUENJIEZMUiBpcyBvdXQgb2Yg
dGhpcyBzY29wZSwgZm9yIHZpcnRpbyB5b3UgY2FuIHN0aWxsIHJlc2V0IHRoZSBkZXZpY2UgYnkg
d3JpdGluZyAwLg0KPiA+DQo+ID4gRG8geW91IGZpbmQgdGhlIGFkbWluaXN0cmF0aW9uIGNvbW1h
bmRzIHdlIHByb3Bvc2VkIGluIFsxXSB1c2VmdWwgZm9yDQo+IG5lc3RlZCBjYXNlPw0KPiA+IElm
IG5vdCwgYm90aCB3aWxsIGxpa2VseSBkaXZlcmdlLg0KPiBOb3QgdGlsbCBub3cuDQo+ID4NCj4g
PiBXZSB3b3VsZCBsaWtlIHRvIGF2b2lkIHN1c3BlbmRpbmcgaW5kaXZpZHVhbCBWUXMgaW4gdGhl
IHBhc3N0aHJvdWdoIGNhc2UsIGFzDQo+IHRoaW5ncyBhcmUgY29udHJvbGxlZCBhdCB0aGUgZGV2
aWNlIGxldmVsLg0KPiA+IEl0IGFsc28gcmVkdWNlcyBkcml2ZXIgLT4gZGV2aWNlIGludGVyYWN0
aW9uIGZvciBsYXJnZSBxdWV1ZSBjb3VudCByYW5naW5nIGZyb20NCj4gMSB0byAzMksuDQo+ID4N
Cj4gPiBTbyBhdCBwcmVzZW50IEkgc2VlIHZlcnkgbGl0dGxlIG92ZXJsYXAgYmV0d2VlbiB0aGUg
dHdvLiBJIHdpbGwgbG9vayBtb3JlIGFnYWluDQo+IG9uIDkvMTMgaWYgcGFzc3Rocm91Z2ggcHJv
cG9zYWwgY2FuIHV0aWxpemUgYW55dGhpbmcgZnJvbSB5b3VyIHNlcmllcy4NCj4gSXQgZG9lcyBu
b3Qgc3VzcGVuZGluZyBhbiBpbmRpdmlkdWFsIFZRLCB3aGVuIHN1c3BlbmQsIGFsbCBWUXMgYXJl
IFNUT1BQRUQuDQoNCldlIG5lZWQgdG8gc3RvcCBjb25maWd1cmF0aW9uIG5vdGlmaWNhdGlvbnMg
YXMgd2VsbCBhbmQgc2hhcmVkIG1lbW9yeSB1cGRhdGUgZXRjLg0K

