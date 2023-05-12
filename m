Return-Path: <virtio-dev-return-12670-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7933C77B7C
	for <virtio-dev@archiver.kernel.org>; Fri, 12 May 2023 14:03:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3E4846034A
	for <virtio-dev@archiver.kernel.org>; Fri, 12 May 2023 14:03:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 334529866E8
	for <virtio-dev@archiver.kernel.org>; Fri, 12 May 2023 14:03:54 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 27FF49866C1; Fri, 12 May 2023 14:03:54 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 123D69866D9;
	Fri, 12 May 2023 14:03:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nyz1Dvacq1suOYa9nkAjc217CsOru3H/7nLQpnnT/FBTnUEtKeC7q7wd3greuxu3Pg5u5YOkwJZrXdKr7oPepdkh/7xpTmnA7/ojdlTothxTD4iQ9YNzCez9y7epfLac7GNhgvMXpk1SuPOpCZjVh1CoLCudJJ1kZD1UUnJvQp8YWTYo+PjYr4RNue6gO84QX+bPgnJAL1wNqk0If7Ply9uMSF7B7UdeWoNX+qGf5FGZJIYL5goL/lQN/owH1DkkA4QnYgf+NXcGTfs5o84KlfQTSYYd0g0xxGEntTsl8f1J4fr7QYiklYl7cx190ZLWpPdCa81V2U2kQ5kyP5ISfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3kFUqaJukVrHgaxjZaYkoki53XvLxD0loorfN9W5V4c=;
 b=CaTmLug1d3qvb1RzOvx528s4UODnPIosZ/TI3XDaHOQWepA4sC2x80n2vWKv2W5ZxZHyaGUp7OwThHeCN29HiO2UR9L4uRs5ugkXCv1lXSWb9tt2ADkWJ+QQuGeSpSEXBH4rwdVpW/p7nugbofqmMzXyrCMi58CUMiTsOiE0nTj/GVy409m3i/ErgZigqphvkyZrt1JOFOBg7N6TsZHv+0ZvJAs/LWk2AXXMZX5SDrBbPEqt3pO8xzflA1hh5m+dslyiOqio7V9vf61Pg5jESdZ11A5DE5cGn5i/2f1CP9a6rDXOaAN4ZJK029waRUePYj2mkOhO02MnsRnr5ynKtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Jason Wang <jasowang@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>,
	"sburla@marvell.com" <sburla@marvell.com>, Yishai Hadas <yishaih@nvidia.com>,
	Maor Gottlieb <maorg@nvidia.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [virtio-dev] Re: [PATCH v2 0/2] transport-pci: Introduce legacy
 registers access using AQ
Thread-Index:
 AQHZf637tzEcVLD5bUyVf2EjaUYU3K9Mhl4AgAJOSwCAANQugIADYnEAgAAP1ICAAAu1gIABh4gAgABl1qCAAAoRgIABlsNQ
Date: Fri, 12 May 2023 14:03:37 +0000
Message-ID:
 <PH0PR12MB5481B86DE1E72B63AB15EF77DC759@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230506000135.628899-1-parav@nvidia.com>
 <CACGkMEt_2B68a+BZ4-vfeDf_eYj5ZhxrDNd6dxuiF85qr0yN2g@mail.gmail.com>
 <20230507093959-mutt-send-email-mst@kernel.org>
 <CACGkMEtfMbcu2OPsH6P2tA1aHh2FKygv=xkJ-e1XQzb62nE1vQ@mail.gmail.com>
 <20230510014534-mutt-send-email-mst@kernel.org>
 <CACGkMEvTs9oMewgrQpYZu1v1wdUXtxsvjqB6CPRf+y4C8EN_KQ@mail.gmail.com>
 <20230510033812-mutt-send-email-mst@kernel.org>
 <CACGkMEsp0i7EyyBBp06wJzrVBLNbH7MP_TT-j7b5c_yavgAmqw@mail.gmail.com>
 <PH0PR12MB5481BCA4D8F6546B3300DD29DC749@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230511094149-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230511094149-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CH0PR12MB5315:EE_
x-ms-office365-filtering-correlation-id: 6cf7dccb-45d2-43aa-4870-08db52f1ae9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 nocaO8Um4wWGnfS7SufoYwueuwPp/eVb1/g2wC9JHSrrusU6pjK7eKgVUkAEXLpF+tJQ5KHiMXgmTyU3bmcCV6hC+4AHlc/kwCAHwWE0A7KdSVRrkeflxP6WTC7c9Cin2YglbyXD3a9LS/8mwz61WPxrZW2QdQHwh8u/P1lOEjA1k4uir5UaK8olWJYXxniK8SJtvyLsSGvVHSnt+e/b3n/eWi1/CMhtOKfws9uaDz3O2r6+8xRJJkX4eAeqpp6SvzTxLppD06Rdk84G7jbIrAMdSzcgUzQd3xNLtgQK1riewzPQNS2Nkz+eYZJuPG4gePjvVUxR5TeJBSAZlLd7HSc92hPrx/eXWNW8iociYQwvB3p6Mw3K0PctXrifKw8WS7KeuNL8QGEz8NEn+idTV/N66uayXr5qAPLf3w/nDrEM4Hz6C0Ruy8NhAiHKEzF/s4qIdx9tOw0fGCV7fI27R/4tJb7Z4zPORn2oCe4OZkS4s5gZi8n2LjrfX2WMM59YcrG6qcq9w39Q37qe19X7z44QQIgvSzIN+2D0K9Y/CTT+GWlJhYI8Wu9AlLRu0tZz3FiLLmUBfMl1EGsCc2lPD0pqjuRdEzb6MBI0u7nn0sY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(451199021)(4744005)(2906002)(86362001)(71200400001)(41300700001)(122000001)(55016003)(9686003)(26005)(83380400001)(6506007)(186003)(38070700005)(107886003)(54906003)(8676002)(5660300002)(33656002)(8936002)(7696005)(38100700002)(52536014)(478600001)(66446008)(64756008)(66476007)(76116006)(316002)(6916009)(4326008)(66556008)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SHczMTJSY2dxN0IyMjhmaHlSQ0piM09FTnRIQTJBenZuV2pZVHFJZ0g3WGpi?=
 =?utf-8?B?OG1JUnNmNTh4dVIvZzkxVS96Q0ZkVUN0czlkRWpkaCt1aFRVUjBEUE1vdUR6?=
 =?utf-8?B?TFVGUVU1bUp2Wk5VeGhuTkxUdXdNVnMwWlJ5c2hsSEQ5c1d2OUlHVTY5YXls?=
 =?utf-8?B?R0RpK3RCcUYzZ0x4WmtuT01zOGZoc1Z5QzBTNVVzclRnZzg3YUdaSCs5MFVW?=
 =?utf-8?B?bW9vejFBb3phbjBvVmRYMzRIVEFDdGE4TVpubGhQTjljdXFkaWlWTy85QmFp?=
 =?utf-8?B?TUNXSUd0UDdobUhSbXJnaGZuS1RDbEl2RjFkVWV0MVZLUDhoQjJ6WEkyb1Jy?=
 =?utf-8?B?dzZhQ0ZkQlJ0RUlMTDJyUUNSbDB3b3JiSGhlWXl0RlU1cEFONUcvR0hzNDZO?=
 =?utf-8?B?VDJ2NXlMbGlFZm5vakFxamhwL0Z5L3dYK28rNElzV1BOaXpBa3ArUzFyM2Vq?=
 =?utf-8?B?QlYzRmg4UlhjV3EyNWpUaldiNGh6bGg0VlZsU3Nwd0ZsV0d6K1NzcGxTd1FC?=
 =?utf-8?B?R0VFTTdzZ09xZTVZMU5SeEZoUWh1QWprU2V1Z2VLYWhleWN6SjQ1dTRPMlNK?=
 =?utf-8?B?Rk1JeFFHU0RYalVVQnllaFpua05iNTRjTkRMQ0wwd0FkTnA0NFd5NjhBZDJm?=
 =?utf-8?B?amx3VSt5bWRCYVhXeXFoRTFWVE1YWlIwSG1kRXcyV3pmMkxWaGpMdDVHb3Vh?=
 =?utf-8?B?N0tnSlpZQnJvQjlMYkF5VEpJNUpZK3lMRDNPSCttMnJ1a3JNTjZoUVp3UmZP?=
 =?utf-8?B?K0E4Uyt5eXdGWjIrRTdGZklpQ3g1MG8xMS81aTlDbkFDeHJSK1NrTE4wTmxQ?=
 =?utf-8?B?Wlc1WDBhQ0VwVk5RcHJJVGdGR3U0SFp1UkZKQ3FoOVl6S3NmK0N2dno3aUtm?=
 =?utf-8?B?WDc0eDJWNzYrZjdLTlo2K2tEdklGRjMzcU5tNXk0Z05EaXE5SlByVTlZTFlV?=
 =?utf-8?B?NjNVYzZKREVhaXpENHY1bHpqYjNBN3Jsd21jYmorTTE3YjBlNG83TGxBMDA2?=
 =?utf-8?B?U2JRdTNwZFV4WHRHU0lITUprOUN0SWx0K3Fnc0l6dVZod3JQUWtycVFHQjI5?=
 =?utf-8?B?UXcrdWU2NU85dklmQlAvWVVCRU8zS1JBVW9rbmt3RTZTOXdyWU9pS3dibW9U?=
 =?utf-8?B?SGpXd3F2QVYzUng5TWZyNjllUlBvNzFsMVBWNWV1b01Hd2h5MkpWOVdzTDVS?=
 =?utf-8?B?cnZMb1pPQ1JlTStMV2xyZVcwQ1hJVlRiTEErMG5BTFlXQ3MydFA5VjMwNHZH?=
 =?utf-8?B?d1ArZDUycGg3dFlYYzdBWHlvUEtlcGVyRFVzQmpsOGRMbG5xazJQK3lNRGVF?=
 =?utf-8?B?djExalgrYUxuVE52MUREKzFvTWhTVmYwVExjVEVUL1RRdU1OcHRtaVhoRDJY?=
 =?utf-8?B?K2dPWkNnNWZtQWJQY0toTUVWM3VKVEZEck93VmFTWXVzd3RIWDFzckN6am9n?=
 =?utf-8?B?a1hNNDlIRXdWZFpEVS9nY1hVMVg4OE1uemNHeDFyazl6YU4reDRvYW44Yytt?=
 =?utf-8?B?NS9tMDloUDQyZUtHNldwY1pVVGREK3Bwam5VNEFRcnFnYk9DcEJKTnZTN3FT?=
 =?utf-8?B?ZHJoa015MnBySk43b2pFR21aUU4rUWxKVFd3OGorYXFwVldLQVZ3eStndWFI?=
 =?utf-8?B?OWQ1NnBpVUhDbE4zb3NiSW82bnMzOGlrNk9lU2hTcExDY0lSMnVUYVQ3UG5o?=
 =?utf-8?B?VkVDbmNyNndyTnlQSVEyTnJYbGVCRVJ4WlFHb1NnTTBvTDRzcGlISVFkdzJa?=
 =?utf-8?B?UG9JZXJEV2VnNk94UyticHZEMVpOZUpTd3BHNlZMNTRLRnVuQVhaUUF6OWVz?=
 =?utf-8?B?MHZwYW1aUWZuVFhkaG5sQ3JGNE9MWk8xdU9nN2FmTWRjQStPcE9razRpakJT?=
 =?utf-8?B?ejZRWnRtMVFXVjNRTS9kbnhVSFFhV0RqQ1AxRlVjUzFPMEdrUWFjdTJMUENZ?=
 =?utf-8?B?V0s2cDllVjR4Ykc4R0FEU3dKSFlENnZUVytMZUlmQnorbVhHaW13a2xnamcx?=
 =?utf-8?B?ZHJoUzZtWUpIc1BPVFptWExad2JRZTAyN05PMHlGWHRCb3ZTelR2UWd5bGlO?=
 =?utf-8?B?RHlFaVNITFV5S1EwTzlyU2xua2JINXRBT045UGFzNnI1VVNzSjJ0TEY4S3VJ?=
 =?utf-8?Q?q41U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cf7dccb-45d2-43aa-4870-08db52f1ae9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2023 14:03:37.2693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xpQE9fBC5C+2iiMfMaaGXE961LItPjsCGifRTJsKEZg7wgXKYLRV6KXTIfEBJtePf4ucET6D1KhnV+JlPtiuKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5315
Subject: RE: [virtio-dev] Re: [PATCH v2 0/2] transport-pci: Introduce legacy
 registers access using AQ

DQoNCj4gRnJvbTogdmlydGlvLWRldkBsaXN0cy5vYXNpcy1vcGVuLm9yZyA8dmlydGlvLWRldkBs
aXN0cy5vYXNpcy1vcGVuLm9yZz4gT24NCj4gQmVoYWxmIE9mIE1pY2hhZWwgUy4gVHNpcmtpbg0K
PiBTZW50OiBUaHVyc2RheSwgTWF5IDExLCAyMDIzIDk6NDUgQU0NCj4gDQo+IE9uIFRodSwgTWF5
IDExLCAyMDIzIGF0IDAxOjE1OjE1UE0gKzAwMDAsIFBhcmF2IFBhbmRpdCB3cm90ZToNCj4gPiA+
IFdoeSBub3Qgc2ltcGx5IGludmVudCBpbmRpdmlkdWFsIGNvbW1hbmRzIHRvIGFjY2VzcyBsZWdh
Y3kNCj4gPiA+IGZhY2lsaXRpZXMgbGlrZSBjb21tYW5kcyB0byBhY2Nlc3MgbGlrZSB3aGF0IHRy
YW5zcG9ydCB2aXJ0cXVldWUgZGlkDQo+ID4gPiBmb3IgbW9kZXJuDQo+ID4gPiBkZXZpY2U/Og0K
PiA+ID4NCj4gPiBJIGRvbuKAmXQgc2VlIGhvdyB0aGlzIGlzIGJlaW5nIGFueSBkaWZmZXJlbnQg
dGhhbiByZWdpc3Rlci1vZmZzZXQgaW50ZXJmYWNlLg0KPiANCj4gRm9yIGV4YW1wbGUgbGVnYWN5
IGRldmljZSBjb25maWcncyBvZmZzZXQgbW92ZXMgZGVwZW5kaW5nIG9uIE1TSSBlbmFibGUuDQo+
IFdoaWNoIGlzIGEgbWlzc2luZyBwaWVjZSBpbiB0aGUgY3VycmVudCBwcm9wb3NhbCBidHcgYXMg
SSBrZWVwIHNheWluZy4NCkhvdyBpcyB0aGlzIG1pc3Npbmc/DQpUaGUgb2Zmc2V0IGlzIGRlY2lk
ZWQgYnkgdGhlIGRyaXZlciB3aGVuIG1zaSBlbmFibGUuDQpEZXZpY2UgYWxzbyBrbm93IHRoYXQg
bXNpIGlzIGVuYWJsZS9kaXNhYmxlZC4NClNvIGRldmljZSByZXNwb25kcyBiYXNlZCBvbiB3aGF0
IGlzIGRvbmUgd2l0aCBtc2ksIGxpa2UgaG93IGEgZGV2aWNlIHJlc3BvbmRzIHRvZGF5IG9uIGlv
YmFyLg0KDQpJIHJlc3BvbmRlZCBpbiB0aGlzIHByZXZpb3VzbHksIGRvbuKAmXQgaGF2ZSB0aGUg
bGluaywgbm90IHN1cmUgaWYgeW91IGdvdCBjaGFuY2UgdG8gcmVhZCB0aHJvdWdoLg0K

