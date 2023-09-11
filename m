Return-Path: <virtio-dev-return-13677-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA03EE57DF
	for <virtio-dev@archiver.kernel.org>; Mon, 11 Sep 2023 11:50:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D7C807078B
	for <virtio-dev@archiver.kernel.org>; Mon, 11 Sep 2023 11:50:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C6B22986637
	for <virtio-dev@archiver.kernel.org>; Mon, 11 Sep 2023 11:50:35 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BC65E986466; Mon, 11 Sep 2023 11:50:35 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A7A69986408;
	Mon, 11 Sep 2023 11:50:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SlGLaPVz/VYUa1ICEJ5r1bqW6oRZEczMq6oZsvYtQEquJmEJD0QFm1wrtrGY/JZ/TkOD9ElYT9eKV5ppM+Bd5SM2WVHZ78YpufDDlPjjqwjugdcd6hJWwFAQjF/+vqhv4bVItbR4lB8i/sFEtaUWWnYio4y69TpSODgHFT3+tBOcX/gc0S33l2k3bEeAsKHqHHqYw9uHNgovi8APanCCJLYtLLWM2lWjG3ICHVkPeDV4La2rk7khy3ZXMgEFy+4+vKA32Yr/lzDMpBvqqWr2hZGq6bHyo09L9TaZcegGLdqh8W3XfBs0gIMhagOA/19zEgaR9kLU4i51F9wQDspiTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6SpBpfmjAVgnIsBfN9lG27DSV1gujelWgq1PDTa8H3I=;
 b=hdsMdVX6WgyQLdPt4q7jd0bJF2/5BQyOo4+kZ+R2iCumQODRk2GKarQgMwbkTuQUl86ovN8jS6j9o9uKbZghnbEbdnnnSaOs7SNG686lU0ijBJ7E/wrVO2wnLTtFwEulAlGgVey4tAlRs4lGEGrfLMNZDxrBSSTh+lUCSB0oriSaAvptFRk1PdZJ9rlsdA8yC8I5WFvqrxP7+HI2VkZvdoE5UMhf26/kO7ewhgwaIPWNXT3RXA05xkATcvErAEhzXOnssh6LG8eX98WM2MQgqqI3n8CbnOsykvqHp0MU2hK/HkdNzAoJMz0WkLuwfdiruGcPZNc5a2fUDABj+rKo6w==
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
 AQHZ4JzDvq0yIsiJnUeYIlWmAxqqv7AU9yyAgAASRHCAAChCgIAAAkbQgAAFdACAAACHUIAABQ0AgAAAWWCAAArYgIAAAHNwgAANI4CAAABkAIAADHeAgAAlTIA=
Date: Mon, 11 Sep 2023 11:50:23 +0000
Message-ID:
 <PH0PR12MB5481E8114A659954251F17DCDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <20230906081637.32185-6-lingshan.zhu@intel.com>
 <20230906043016-mutt-send-email-mst@kernel.org>
 <CACGkMEu4R_nUFmpoNesmjJ-PtoE5brpWh8NLruWhEWycm2K4yg@mail.gmail.com>
 <PH0PR12MB5481A50B1B13CE1756B98D0DDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtMmwWGJDYe5BLvLCcetThv-yfPR2QbphNuuh+bp-+ikg@mail.gmail.com>
 <PH0PR12MB5481ED8DC23DC6D42665FB8EDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <eb6c350e-1198-7d83-a553-99c9c8c21edc@intel.com>
 <PH0PR12MB5481760E00AD18DB8BF91636DCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ad1dd3a6-7c11-5c6b-b50f-d608ec027dcd@intel.com>
 <PH0PR12MB54819C4A4220712DCD57AD56DCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <fff7720f-6019-bd87-b14b-c0bf996f3959@intel.com>
 <PH0PR12MB5481D11A7DF45292103D9290DCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <88b8b14c-88d8-1f76-0e6e-7b5f334171f1@intel.com>
 <PH0PR12MB5481CBE0CDFF4ACD712F371CDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <2b3e8da1-5cbb-f990-0c1d-c0e894a73486@intel.com>
In-Reply-To: <2b3e8da1-5cbb-f990-0c1d-c0e894a73486@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DS7PR12MB6264:EE_
x-ms-office365-filtering-correlation-id: 34444967-a2b4-4013-25b5-08dbb2bd4844
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 UosLceGHNqUoyncV51N6fTqhxwwfdLyFK2NPF+K6y7s3+FrlAa8TWkkU9g+N4zMrYc4214HJ+Z21GCsNWijWjBIXEyKOWdXNs89fmuQ2Dj+1Y38VU6JtnQN+3rWY3LocoatVjKlIM09NdhCGZjCZWE23vV7MTj0g82KwgvPVPCU7WI+3kbQSKm8Vq2t2IApBuYRQU56yQgjghP9A08SDBIhggHgHb8fQ9fcxwMgHQhWEHjczNpLx3QuofDDWpIX4U56AdyVSBqwQL08YgFJzOxU+BZga9u6Kyrbh3HRm885MAcldi8S9tsjOtYGcosWdSEwG/KibiqWlTA3SGUKgswz3knQltL/O9GUPZLSZ29BDh8nI08EJAV3UR1lEwJpr3Yj9O/AcTSDs8bw2ZFxpMORwuKZSnNA8k4BgoR+SJIFeMoZIi/rvXEz/L0AxmjRi5p3cMzGNgSf7C43tVCjqYCK1FX7SBkPeGmHxeJxD00mmZGwrHeLg+m+f8yn2wLhWarVl1Qs85S6tjco6ebhfm4KK8/brac8SpFnp17jByzK7vrMtjQDiGKKH9vwhQ+O0GxV+k6Z55miuxLnqd9GgReujwAuojtLK/eOQqZ39UR2RTM7fO4t+1rdUbET4DNpeIMr1K3D+Q+G1UxUYmuUXBRoh0dbNrm4gEZfWoVJJEnY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199024)(1800799009)(186009)(83380400001)(9686003)(5660300002)(52536014)(33656002)(2906002)(8936002)(4744005)(316002)(4326008)(8676002)(66946007)(54906003)(41300700001)(66446008)(66476007)(66556008)(64756008)(76116006)(966005)(6506007)(7696005)(478600001)(71200400001)(38100700002)(122000001)(55016003)(86362001)(110136005)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eS8wMVJHc1hJWngyTkRTQWhkRTdsMDRzeFp4UHlHL2d5NStzeUl4VmU5VnIv?=
 =?utf-8?B?VG9BVWJGOTNGUmg4NEtEMWViWGpoL1FhZDIyQllxekNXNnV5TG9SdXlmUjhR?=
 =?utf-8?B?akFMbVFOanJHU0NBM1ZSd1VQcnRjNnFPYmlLeVU4Sm1aMDhyUTZxaC9tZGRy?=
 =?utf-8?B?WldwUTRMKzN2N1hsVjVUNzkvSktjR3NaWDA1UHFDV2tsMkJDMmRtMG5UREw1?=
 =?utf-8?B?WlAvajlwc0hkWlBqZWFUc3lPT1IrRE00Rnc3SE5RUUw0am8xMEEya3ozWFZm?=
 =?utf-8?B?d1ZiczBXa0w1Tys3QXR6Yk54aHQ4eDN3czNhMEY0aHFXelFqZUgxcC9Xa1My?=
 =?utf-8?B?a2xpTTkzd01ha2NSTDFsYjBlVVRPSlBKRnRiV0g0RXo3UEV5akx6RTF4Mk8z?=
 =?utf-8?B?dkNEV1VqQWE1NEZ2N1VYeFBSY0Z4RWVMZVdnMDJ4T3pHZVJwYTBjYUNQbGRs?=
 =?utf-8?B?QS9yeXkwWnZnTzhld1VoUTNaeHNyUHY0eUUxUWtpbGhBOTNlaHZ3WXBmQXhj?=
 =?utf-8?B?STBOR21Rb3Rka1NsdS9PZVRpUFJwWWVxT1g0SmtZQy9JRjlWTGtMb3hoTzlP?=
 =?utf-8?B?WnQ0Qms0K3VMS2ZKdDJoLzdTUGkyVExMcUloT1RadzFzR2tuaDhOZmZjS1M1?=
 =?utf-8?B?Y3FnQ2ZROTFnYndNZWwyUGIyalZFbXorVU5CYmFnYUg1ZzF3OTU4NUpHMXVQ?=
 =?utf-8?B?b3hENXJuSjZ1c1RGcjNiN1l0L3RKanlndlJRTDVWaHpudmZnRjVFdnhhRk5C?=
 =?utf-8?B?TmtLcWQwQ3F5QUJmWVFRaW5XVFFJTXVxOG0vOVdPZC9DOVVIR2RjQWJqRWNP?=
 =?utf-8?B?YW9FUjlZOExBS05iYytuVm9pb0drTHo1bERLekcreG1Da3VZbCt6dkdVT0V2?=
 =?utf-8?B?QmxUSkpHNnJaRFV1WTN6b1BCYnVoZXA5TklSYWIwTUR2Q1NQRzNCeXRqcG1E?=
 =?utf-8?B?MDB2SWZsMjVpS3VUeGVyWlBvb1YvWmhNOVhOaW9lZGp2a2hOc050c2hRZHpR?=
 =?utf-8?B?TThlRDl3cVcxSFZ0dHVoQUdXVC9NTFo4RWNOWnBVekR1RkZmOG1LRGRaMHlT?=
 =?utf-8?B?MUFnSDZuOWZtOHU2dVE5S1gzUk5mWnRISEJpZHhQZUNFM2RBa3J6T1cvYW5T?=
 =?utf-8?B?czdYNGYzbDFCQW85N2VNRWx1WVViRlFicmRpMngwZy9SVExLV1ArZDRRQUwy?=
 =?utf-8?B?MExqakpVTFhwZnhsSnpIOXdjZ1FlcDVXcFhDNVhNMnNGQ0R0YmtsMzBjZjE1?=
 =?utf-8?B?dDBtOGptMHhzWTZnY1RCSmFJTlREdU5KN0tPWHlveks3SUJ6MjBXd3I1eGtC?=
 =?utf-8?B?Y0tqZXAwbjE1YkJ5TzJJNzRNd0ZJSlNxV0E4UlRkck01YnZGN3VGQ2VTRW1F?=
 =?utf-8?B?bmRTQVkycm1hWHI5cUl2TDNxTmVnSjlwMGtRSkpOZ1hQUkVzY1NXa0dpRWVu?=
 =?utf-8?B?RTVocWNIRFJRVzlFamlneUhOV2hCSkIycnBsaXdmanVIc1luamtFa3hSVmNr?=
 =?utf-8?B?K0IzVWd0YjJpV1lYVEtBNmxOdy8vd1FIYWZ1YVkvWktkT2NiamZmVkxnK3U5?=
 =?utf-8?B?VHh4VjF6Q2toVWNxc1FFbmU0Q1UvQkRmTk9rbkRBRjhjNHBtclBmVitlRTJl?=
 =?utf-8?B?QkZiY3dwcjZjWXA3ckdsQ1JUY3hEek5sSStpSjFTTmFoOC9GT0tZcUNZNGQr?=
 =?utf-8?B?OEladzVBRGxMR2k2Z0h4OVFoUE1TbWhuSkswL0pPbk1iS1p0R0U1bUlkOXF4?=
 =?utf-8?B?bVJzMksvL3llanZLbXJnZE8wYTlYWFFmRHhmYy9iVGZ5N3ZESXZNc3dCaitM?=
 =?utf-8?B?dXEvY29ndnVJMmlOWXYvS0FXVlNEWHZIeVFEOGZ4SHNMTUN1cEZHTTVxM0Rn?=
 =?utf-8?B?RHFxNkpXdGlRdDRhQlRtemFuMTZ0aGRONVNWTXVNVjU1RjVObjdkWFJEWEY1?=
 =?utf-8?B?YVJWcDZjV0psUDBqdytNdGVUY1NEcHNTL0hVcml3ditIbVBVdkl6Um0wN3F3?=
 =?utf-8?B?eEVUL0g0cGtHMjhZNVk1aUVmSjRSUXI1VnNlM0Z0MU1lY3dVYkR5L0FsVUM3?=
 =?utf-8?B?SFF4SVA2UThGQ3pWZGZnQVlLNlE4ZFZqb1l1L1NUUmt1SlB6eGIrQk5aa3Ro?=
 =?utf-8?B?UzN0YUdpdlpPNmgxeEVDamxtUVJwVU9vdzZwazdXZDczSHIxekdIZzhYcnky?=
 =?utf-8?Q?mBeI6B2y7c9qWXNjbBN7t7OoI/8sCMUpbQkNL3zbS7cN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34444967-a2b4-4013-25b5-08dbb2bd4844
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2023 11:50:23.3485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cslE12k9xdNmsweIYD8d0P4MFD2neQ3uTrio29kv1/X2eFQoPFsT42G5YvM69dL8QDo9yTECJ+SK/CV4OzFmwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6264
Subject: [virtio-dev] RE: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE

PiBGcm9tOiBaaHUsIExpbmdzaGFuIDxsaW5nc2hhbi56aHVAaW50ZWwuY29tPg0KPiBTZW50OiBN
b25kYXksIFNlcHRlbWJlciAxMSwgMjAyMyAzOjAzIFBNDQoNCj4gQnkgdGhlIHdheSwgZG8geW91
IHNlZSBhbnl0aGluZyB3ZSBuZWVkIHRvIGltcHJvdmUgaW4gdGhpcyBzZXJpZXM/DQoNCkFkbWlu
IGNvbW1hbmRzIGZvciBwYXNzdGhyb3VnaCBkZXZpY2VzIG9mIFsxXSBpcyBjb21wcmVoZW5zaXZl
IHByb3Bvc2FsIGNvdmVyaW5nIGFsbCB0aGUgYXNwZWN0cy4NCg0KVG8gbWUgWzFdIGlzIHN1cGVy
c2V0IHdvcmsgdGhhdCBjb3ZlcnMgYWxsIG5lZWRlZCBmdW5jdGlvbmFsaXR5IGFuZCBkb3dudGlt
ZSBhc3BlY3RzLg0KDQpJIHBsYW4gdG8gaW1wcm92ZSBbMV0gd2l0aCB2MSB0aGlzIHdlZWsgYnkg
ZXh0ZW5kaW5nIGRldmljZSBjb250ZXh0IGFuZCBhZGRyZXNzaW5nIG90aGVyIHJldmlldyBjb21t
ZW50cy4NCg0KWzFdIGh0dHBzOi8vbGlzdHMub2FzaXMtb3Blbi5vcmcvYXJjaGl2ZXMvdmlydGlv
LWNvbW1lbnQvMjAyMzA5L21zZzAwMDYxLmh0bWwNCg==

