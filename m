Return-Path: <virtio-dev-return-13973-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51328E810BE
	for <virtio-dev@archiver.kernel.org>; Wed, 27 Sep 2023 10:18:46 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 96AC2C6238
	for <virtio-dev@archiver.kernel.org>; Wed, 27 Sep 2023 10:18:45 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8AAB49866BA
	for <virtio-dev@archiver.kernel.org>; Wed, 27 Sep 2023 10:18:45 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 7C14B98640F; Wed, 27 Sep 2023 10:18:45 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6AB5E986413;
	Wed, 27 Sep 2023 10:18:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QCymlDjsge+QcpUZ6IlN876Ecm2+AWwSsZfMJ+CWdf1jgv4627W1Y+jVby5VHrCfcq+proaleRL/a98LPlhXbUjYKuP3d2RMvqTqEAYX6YvkN90bJ0fCQGvVh3XvHQBXfIa+wX7qr/fVKODdTwZEQvnVqUwRBLzQSoaqSU4Vk8bA3LrOSBSaPxJwKY39FzZfT9X0j0bR8gEmR/6Wxa14mAuq51CAVywt4BrY1OGrsYBsbGbTOzkBuLbkJ8KLbv/1xed7ydpkL4l1RwsCI8nzNYJOcEGN3hluJXUZHbjN3eFYuelDQ0cxw5hxjg5zhberJwC4Jxxk4oleePTc0vuTng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3lu2EPVc06Omo1NBiQkIbrQirimCzi5L1gjfyUIs+g=;
 b=nkZAvwkjRpJu+OVMLGpstR9mlYkM04C5KQeox3NxxZoOXbFYf71pt+7CB46GskvflihxQ2vOMPGMyrsS5OlRIz2+2XD7ttYkZFE+A6N9nLk/uLPxv23WDDeqNUXw3ewOWUZcMlOIA4c1u79CGcz03sfoND9zbPESPjIAXBvEW5v3EU83eKIO7WWdRn5TEN/mcugBNwX1pl4YDHY8V/VgXIksp/VUSc7jlu+pfW7qBmtoyUzpgkyyYyUw9PgTXqTB2OkstEd9HVSrz3mq6TLXAWyjVM0E+S4WKATyFiekpAK0vjYJfwUDK9JTJrYzeRTdb4VjFukAxR8nWwPA/S6WdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "Chen, Jiqian" <Jiqian.Chen@amd.com>, Jason Wang <jasowang@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	David Airlie <airlied@redhat.com>, Gurchetan Singh
	<gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>,
	=?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, Robert
 Beckett <bob.beckett@collabora.com>, Mikhail Golubev-Ciuchea
	<Mikhail.Golubev-Ciuchea@opensynergy.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Stefano
 Stabellini <sstabellini@kernel.org>, =?utf-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?=
	<roger.pau@citrix.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
	"Koenig, Christian" <Christian.Koenig@amd.com>, "Hildebrand, Stewart"
	<Stewart.Hildebrand@amd.com>, Xenia Ragiadakou <burzalodowa@gmail.com>,
	"Huang, Honglei1" <Honglei1.Huang@amd.com>, "Zhang, Julia"
	<Julia.Zhang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>
Thread-Topic: [virtio-dev] Re: [VIRTIO PCI PATCH v5 1/1] transport-pci: Add
 freeze_mode to virtio_pci_common_cfg
Thread-Index:
 AQHZ6u55wdLgYEJT5UeWhzYWiXOCmrAksLcAgAAjGACAAVz9gIAAUOOAgARfDgCAAYpigIAAB5eAgACIvgCAAAR0YIAAC5SAgAFXTVA=
Date: Wed, 27 Sep 2023 10:18:37 +0000
Message-ID:
 <PH0PR12MB54817697DBA852FF2E1F619FDCC2A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230919114242.2283646-2-Jiqian.Chen@amd.com>
 <CACGkMEuEXk2UzXU7sFUk-nHEeE7QoB3kbjnHgktY7KWuK71Xrg@mail.gmail.com>
 <BL1PR12MB58490A484087B2B2C37B6E43E7F8A@BL1PR12MB5849.namprd12.prod.outlook.com>
 <CACGkMEtx-i_9dgdONFzEmmWYNRhaoJQZX7a5OmLfDvGoUaajPQ@mail.gmail.com>
 <BL1PR12MB5849E38DE89D80B8A4CB7128E7FFA@BL1PR12MB5849.namprd12.prod.outlook.com>
 <CACGkMEv0d3frw9KJcC3qDs0p8ZeWg6dowNEHcAHsgaOTm4CAAQ@mail.gmail.com>
 <BL1PR12MB5849B427B23D1ED269808463E7C3A@BL1PR12MB5849.namprd12.prod.outlook.com>
 <CACGkMEtuRwAig_AbMA1YFa9YVw2aBQJDhZ06ZiD_QugthPDROQ@mail.gmail.com>
 <BL1PR12MB584991A9503502EDCB6B9D0BE7C3A@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481E765DA98E7AD3D1BED15DCC3A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230926075503-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230926075503-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CY5PR12MB6477:EE_
x-ms-office365-filtering-correlation-id: 2ad3870b-fe1d-412b-1e89-08dbbf431d33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 A6Y9VnGEAPdmt/Z7IGNurjhJD+q4pq96sJ4PJvcaMKXRPvFWERUYfwOMY6bQVAOR0WK37Pm4b7JDhCRfsgwUExlmkMbvuVExKftKfx/+Dx6saON6sFdG0hqfdHkKhgiT0F9DGuFE5qE+5M19nT16Xwl6vHKSNupjOhOREGUnqmcpt8gyg/mTdrUNXPTSIU49jWYKx/BHj3f6IqKFm6TnKkyxhvBuCF8/Hd7hvHZABl46z5yYsQcr+ttk4X3llsBt2+bEXewttdoR4gc8CmeXXlQlkunjPpQcfrh09oshL1OPyZNAd/XzN/bEBNF15BP6H+1YQomRtOFJ7mqykVbQlXF/nFktYXoGM/OeAL8aP0ty+O4zVN7rtH99TKCxsemzL61ECpgpA5+LNHvyTbVJGBSvAVDsQBxPcoOILgLY7VTrqS1puQqQOItERgSW4fRDk+e1VEBqiKf9UaB0hSnNMRpBeUPpYn34eaPhohI5S9FsCtRLAgVaY+INePCUKnXSW3PLDFOet2qrHQZbe29nDPy1+8Ft5Pp3E+GhQroxxr5mOWlIhBpvcsPMB48GqjKxD4lFbvaXiM50WHz1EhlcQdBQMDzJpATl1e+mcm2mAkkyA8zjhJQ+im59vcN17KRk33kJrPCYSnEmYvzV1V52thV6Xs+B+dewTTAXQO5WZTU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(376002)(346002)(366004)(230922051799003)(451199024)(186009)(1800799009)(55016003)(7416002)(83380400001)(52536014)(8676002)(478600001)(66556008)(54906003)(64756008)(71200400001)(66446008)(76116006)(66476007)(6506007)(66946007)(6916009)(966005)(7696005)(316002)(9686003)(66899024)(41300700001)(5660300002)(38070700005)(38100700002)(122000001)(2906002)(8936002)(86362001)(26005)(4744005)(33656002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SEp3RDNjNm5PM3ExYkdQYmxCUlcyRlFzYm01YlNqblZjeFRzaWR0L2ZwdmVo?=
 =?utf-8?B?L2ROSkNoOG4zYitqYnVKYmVMRkhNYStBR0tkb2toTzIrUW5tT0pBVFozTkRO?=
 =?utf-8?B?T1pndEZoTlZWeGduRmYwc01LNkpscFk3SFFSN3ZaZ3o5R2JYaks0SlhYQytI?=
 =?utf-8?B?VjZwS1lyWnBWVDBXT0hiMStmemtMYnVoTFVmQlVWSFFOZUxpQkZ4bnI0UnIy?=
 =?utf-8?B?bDRabHZTL0V3bmRQZmJ0UjgyTmwxRWdQa0p1US9QTHUwK29laDlpdFJIemxp?=
 =?utf-8?B?QXdycUFaT0dHT01mbGNnL1FtcTlDeVRPUEhON0tBMUp6Si90Ty9RN2JPVU5i?=
 =?utf-8?B?ZUR4cUUzZUIyK3hsc2VTSThBejlMbk5lUTZTZGp2R1VDMS83cy9VWjlNMzg3?=
 =?utf-8?B?aVo4RUFXV25IVWF6Mk1reGMrMHRFZ3BHSUVsblpWQ3J2Qk9JU2ZjTG9NVFFx?=
 =?utf-8?B?U2pXQ2NHa0kwZzQwbC9JOHMwbTZnaVMvSHVmcGhmSzY5dUcvbzRLcm9kdHJ3?=
 =?utf-8?B?SVhEaUU5OHRscmJTZDJmSE15c1d1d3dVbzJNajdXQTZDNWtCZGxPSnJmSlU0?=
 =?utf-8?B?U2RoRTlBczVRc2xiU1AyR25BcHJ6VllTRmdTdklzcjMyZjVRUGJlTmlyZ3Ax?=
 =?utf-8?B?dWJOM1MvUHMrc0VObGNJZ1Yrc1k3Vjg2WElOZEpWdUcyUmkvcTh5WGVjZFhS?=
 =?utf-8?B?UXRKYUdidm93aVBZQTd1em5xWnJscUF3QS91RDdBdk1QdCt1TXJJZEJ4aW4z?=
 =?utf-8?B?NUVBTFdYMGxMOXJRTTNMK2FORTRnenh1Nkc0NExST29jZHZPWUlCUXZ5Mmh4?=
 =?utf-8?B?ZEQ4Y3NodXM2ODZzZWd6SUFFTC8rb0EzSHpFS1VRMHRubG9iak1wTEp2czhy?=
 =?utf-8?B?a0dKY1FSSDJIZnhGelZmUUdUNzVuY0Jxd1lLa25ScFpMUkthcnUwenFidEs1?=
 =?utf-8?B?NElyK0hWMjRML094U0pwUU9nNVkwaEZRWW9Zd25EQ25TK0NrTEhwZE1qQllp?=
 =?utf-8?B?UlhwV0hyUE5nbU1mb3RvY2VXMXN3b3ZIdzk4VkFCamZsbTRsUzdTZjBGaTk4?=
 =?utf-8?B?RVZxRXhsZlI0ZFgvUTNyT21Lb3FZTnkxd0ZXOXB1ZnhPQTBOMlRDRnh2ZFJF?=
 =?utf-8?B?UnhHejZ4ZHlWeFRrWHVTd2kwTVZ2SVl5OUFhZGdBS2pER2pRb3U4dS9kZGwr?=
 =?utf-8?B?YTNRK2huc29pNjlMb3pvZTI5R2xnVUhlZVZQVFJGaUNjWTZqaVVtcVVVRitm?=
 =?utf-8?B?a3F2THV2eEZCUHkrbXV2bUhNSUVEczdVQjFyZzEwdXVCOUdpSUwwdzMybjVM?=
 =?utf-8?B?bG1zTCtzYjJVbWpPK281L1B2clpzeUlpWEF5ck9DemUzNHZKTjB6NjRlRTEx?=
 =?utf-8?B?V0p3ZFlEcm4xMlVOMm01WDNUL2Z0UlFQWkZTcGR2cFFpL2QzT0VMeXdURmtN?=
 =?utf-8?B?dFRSTUhmZytkYmZDTDNDK1VOOTd2VTY3NjJKZnphRWdxczlBaVR4Qmh3Vy9H?=
 =?utf-8?B?U3JWZ3lVMHU5RGxGbkViWFllL2xudDdJUXl6TzdvWDkyc2ROMUQ2eXRIdTll?=
 =?utf-8?B?SGN2QkV6dlRzUVRoQnUxM2hDQThhcEYrZ1l3QXQrYUcrMXVXQURpeFp4RGF4?=
 =?utf-8?B?SXV1enhhQWowSk1uNDhWNmZXaDJqMXhNTG5PZnYwWG82cG9nLzduazdaY3Bx?=
 =?utf-8?B?QkF2MVpHTUdjL2Qvd1NkbmNHR0dqYW9PRGJEVHlINkRvcnFtR3BrUVlKRGgy?=
 =?utf-8?B?T2pMK0ZnMUl3QU4yRXN4dkhoNWtBQmFycWJsQ1hXZ3FQRXd2LzdNSFVMUHox?=
 =?utf-8?B?SkZNZ3pUMGd0MzBxWXQ0a1BrZlNuV2NPM3ZLZTVEUmNqTTJsVVAvNHhuTlA3?=
 =?utf-8?B?T2ROVTRWVzRCa3FqbGhYQTFHRnBjd3JpZ1ZaQlB0d2E3REVreW0yeWF1Ukg3?=
 =?utf-8?B?MHdKRDJ1ck1KVE1yN2Iwa0RLTlFieVVBSlRYa2NaZVp5TDBxNjl3SWdCQnpD?=
 =?utf-8?B?RjJtOHdSNFZrNWhaZ0E3RVB2Z1JrUEF6ZGYvZkRVQmZYS1pWQ1ZjTjlQVmJy?=
 =?utf-8?B?TmQ1TWxydVNobXc0RkNNSXhDNjVzajdYMEkvVzVSSDE0WkJrSkNIcG9XV0Fw?=
 =?utf-8?Q?t4qk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ad3870b-fe1d-412b-1e89-08dbbf431d33
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 10:18:37.6235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cysZzoaJbNCqUv2OzPqFpc3raAcdxr9EG8eHbmUI/5M+rCUFqKkcks7iyK5dfvhZbolpmJSolVaNKTsf3Mr7MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6477
Subject: RE: [virtio-dev] Re: [VIRTIO PCI PATCH v5 1/1] transport-pci: Add
 freeze_mode to virtio_pci_common_cfg

DQoNCj4gRnJvbTogTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4NCj4gU2VudDog
VHVlc2RheSwgU2VwdGVtYmVyIDI2LCAyMDIzIDU6MjggUE0NCg0KWy4uXQ0KDQo+ID4gV2hlbiBu
ZXcgZmVhdHVyZSBiaXQgb2Ygc3VzcGVuZCBpcyBvZmZlcmVkLCBndWVzdCB3aWxsIF9ub3RfIGRv
IHJlc2V0LCBoZW5jZQ0KPiBubyBuZWVkIHRvIG1peCByZXNldCB3aXRoIHN1c3BlbmQuDQo+ID4N
Cj4gPiBbMV0gaHR0cHM6Ly9saXN0cy5vYXNpcy1vcGVuLm9yZy9hcmNoaXZlcy92aXJ0aW8tY29t
bWVudC8yMDIzMDkvbXNnMDAyNjAuaHRtbA0KPiANCj4gSSBmcmFua2x5IGRvbid0IHVuZGVyc3Rh
bmQgd2hhdCB5b3UgcHJvcG9zZWQgdGhlcmUuDQo+IA0KPiByZXNldCBpcyBhIHNpbXBsZSBvcGVy
YXRpb24sIGl0IGp1c3QgZXJhc2VzIGFsbCB2aXJ0aW8gc3RhdGUgZnJvbSB0aGUgZGV2aWNlLiBJ
dCBpcyB2ZXJ5DQo+IGNvbW1vbmx5IGlzIHBlcmZvcm1lZCBhdCBPUy9kcml2ZXIgc3RhcnR1cC4g
TWFraW5nIGl0IG5vdCByZXNldCBzb21lIHZpcnRpbw0KPiBzdGF0ZSBpcyBhIGJhZCBpZGVhIHNp
bmNlIHN1ZGRlbmx5IHlvdSBrZXhlYyBhIGd1ZXN0IHRoYXQgYXR0ZW1wdHMgYSByZXNldCBhbmQN
Cj4gZGV2aWNlIGlzIHN0dWNrIGluIHNvbWUgd2VpcmQgc3RhdGUuDQoNCkp1c3QgZXhhY3RseSB3
aGF0IHlvdSBzYWlkLg0KUmVzZXQgc2ltcGx5IHJlc2V0cyB0aGUgZGV2aWNlIGluY2x1ZGluZyB0
aGUgc3VzcGVuZGVkIHN0YXRlIGFuZCBhbnkgb3RoZXIgYml0IGJlaW5nIHNldC4NCg0KUmVzZXQg
ZmxvdyBjYW5ub3QgYmUgaW5mbHVlbmNlZCBieSBzb21lIHN1c3BlbmQgYml0IHNldHRpbmcuDQpJ
IHNhaWQgc2FtZSBpbiBhYm92ZSBbMV0uDQo=

