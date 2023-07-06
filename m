Return-Path: <virtio-dev-return-13249-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CBB6EB64D9
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 04:21:18 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8410F99168
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 04:20:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6EF56986809
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 04:20:44 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6107F98645C; Thu,  6 Jul 2023 04:20:44 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 921CD986729;
	Thu,  6 Jul 2023 04:20:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FOwwgv2VuNjSOKa2cBE4aAnNuk15HYeCvrU8a80yuu9nWqlZgwvgizXPUIOAzZbG3cnDwOjzNpsHOYlMoVFbxr9Wr7jdKAsJ8bdT5vpAeT9AI55wKkSrLnAFuidatQgfEqc5ZOuVct1qh+WEInAE6MlyZyMzwgDTnA1HLFJ6FTpmkuegdTj/6bTtsWK1Au1Q5u4bY2cJe41Y73DpOqcSLLJc9xazDwLla3h/sXP2g40EfbMHwCE0eSt1hPdKv9ceXIaW+6UWBY6+lSZyA8lgJDu9bpH8BR0Ycm2SeMu/vZwLe8WDMCElnZX6d997JoPwyJR4hmXZTw0+IfTQRWtG4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYD+ONj8QrqD3FK1/VStUBUwGLKYZqjp6QlQFUrgW2E=;
 b=WpHUcGkOKs5PvpSMtiVU9w1x9xTLn6hHChNeMk2b2oBww5Mct+VZX/m3LRdINiNcfSvcCiG3pkZiAVXVaFMTt9uXi1jpIDp1MHjyveEbkRC+SspKQtV2zxgRyBRdUd3vBGZ/GEYmCHDV2kAZnKqxDd3vmkB4j4neurIOqtDRuwAVt+Us/NyBEMOyGq0mxo9sL6COZi7HdBEGBlKp6Ggk8ebisbN0RDVbR1BajcZrbm6FQvxoPRZr56msxcONdV/DjqZdu7JzDxjitEgyg6N3VpNRoVMQHzJU6iZbjjPZlxv44Az4GoYp0ptVCHn8yrJqEMtEUQCh8z3+3OoPG7j/pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "david.edmondson@oracle.com"
	<david.edmondson@oracle.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, Yishai Hadas
	<yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>, Shahaf Shuler
	<shahafs@nvidia.com>
Thread-Topic: [virtio-comment] [PATCH v9 0/4] admin: Access legacy registers
 using admin commands
Thread-Index: AQHZrtCLWAcU8k1wLESQt7niIKXarK+rBJ+AgAEfwSA=
Date: Thu, 6 Jul 2023 04:20:03 +0000
Message-ID:
 <PH0PR12MB5481D2368A718164DE18DCDCDC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230704233724.22394-1-parav@nvidia.com>
 <20230705070758-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230705070758-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH7PR12MB8056:EE_
x-ms-office365-filtering-correlation-id: 57363a90-7cc5-470f-32e5-08db7dd84559
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 FkNgZkJo93IqlQQJHxTvDvAE+npeoolscLqwfOEmAll9ztUNz8InLSzF1rSYFnmBuncjINsbdx+U1i/QMVH3CdBi+9mP74qkGa2GJLl8qz8Bd1Hnrou31dC5pPipSQc5I7eKfc9Podq5immegip18wA/pl2WnyT1VHPoT45g1Ss7+9gMdyRQyYRfqlHOxq1/SIVkfN+jYpjKHtxwNugj/bMybPWZjKSww5yKLWNq9vdMXMrEjf4zjURqfnzQnursZNxt6rSniKhxOJe3dv1cry4B3VmDoz/3pgMxVcsmt0KU5+X8w0hGU15fO9M8+Ii4shmmAwO5vdidycyv6yV2dbEoMvUjd4+BKoyJzExPvP+lOl3RZMHgbiDkqfpgM0+i4P+ATXnOpYytWke2lujotgCd4LDg8YvFxHZY+oj4fDtxyZjuNHkcFSX8mlT1aqrtwkOgXXoidN4HVVo6LX89yjYLJX1r4FNAWbB05fdIKYCFItpkZva0yZ5ngrJhkJdmqaDIPquESkdbWuZigglel5lMF554H9siXcPQf+jy1IhcpJf0wPRfKq1GllQbcpzbtCFyhpy3Sn89iNU7L5qnAulDU68AU+whnks0tGYqboA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(366004)(346002)(39860400002)(376002)(451199021)(33656002)(316002)(76116006)(66946007)(64756008)(4326008)(66476007)(478600001)(66556008)(6916009)(2906002)(8676002)(8936002)(52536014)(5660300002)(66446008)(41300700001)(55016003)(86362001)(9686003)(54906003)(38070700005)(38100700002)(4744005)(7696005)(122000001)(186003)(71200400001)(26005)(6506007)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TStObTI2SFRhdFIvUVJCcndLSkN2Uks2ejVLSHFVVXVCeHhxUUxDSVdKdE1z?=
 =?utf-8?B?c1Q3SjZXdWdvQ1o1VWV2N3o0UVZweEw5SkloTGY1MXdEcHNQME4zMllVK3Rq?=
 =?utf-8?B?U2JZNzZ2S252S0E2dEUxOWFaQXd6akV6clkwTUVDRFdKem5ObE95QXd3aUVl?=
 =?utf-8?B?K3ovSzgzT0ptQkxPckg0aXVLMW5XS0VWSjZIYTR2Wmk2MG0vZnoya3h0WGxU?=
 =?utf-8?B?WGlDVXd1VXpELzJDRzZNcVdMYlFFdU51cGRGeHI5UUlYREdRUkpVNm1VZS9j?=
 =?utf-8?B?eGpNblVzUlNxZ2JrSG8vemo5dmJIV3dIV0lnS1lPRHorWkNoRGdmY0djeDZT?=
 =?utf-8?B?WTBwVFRzaVQ4SXJrSEVHMFl6UHF1Zmo2MGhzMmRVbWRKTFdzdDQwbW83T0Fl?=
 =?utf-8?B?TUM5MjI2Nk0wY0Y3TGdSTzBON3ovdUFlS25DV2NXK3ZMTXZUZkV5Rk1vWE1G?=
 =?utf-8?B?VDlucXlDeFVHdFVsMVVTZjMzSmZ2clZ6UjAvQTIveTZVNDNNSGp3bmxVNCtY?=
 =?utf-8?B?WDBoNlJ3ZlRPV0pZUXRPNytyN3FhVzBqWnk4ZXZZYmJiancvb0tMQTMwMkJh?=
 =?utf-8?B?RDdUTlBpUnVVMUkyVkx2c25YUGdyS2lwYzBEREZQaGhodDd1VG1WbVFtdTJh?=
 =?utf-8?B?a0JrOXc3dE1DVWcrVFFkT0kvSEFsOGNjTUxxRkhQRlFzYXlsVnhoUzJkYTc1?=
 =?utf-8?B?VUJqT1EzemNyekpFSWJYSm5lYTEyOEI4YTYrYXZHTGVWcVZ0MzdIV2l4RFhm?=
 =?utf-8?B?dG9WYTBFa3hQc2lKUEh0SUgwdGVWQW1jRVA3b0djOTdXalJFY1U5bTU5MmV0?=
 =?utf-8?B?QW1vVXJJNVRCODJUMVI1OTl0em9aS29DbnFkSWZ1NlBPaUhhY1JyVEZvRm5z?=
 =?utf-8?B?TU1OWEhNekNQSm4xcXhLSWNXaE5QRnFzZ0VYM09SSExmRkJkenM1RmZZMzhv?=
 =?utf-8?B?QzluZytqQ0ZqWnp2bnpOWCs0eHJHdXBLQ3hIQlpYYi9GajdiUDFIR282Rm9W?=
 =?utf-8?B?S3VtS3E4WDJnNkF3T3IyelVOU2RxWUZjSmVOVUtXcDY5RGlod05kMUlEcE9z?=
 =?utf-8?B?eEVIVnhtdDRTSXFyZDdZYlphbUVtYzIvQUpFOWJXYWMzd0tlbmVFMHYwdWVy?=
 =?utf-8?B?ZWlOZTJwZlpxbmZycXlaQUg5Zk4zMEttMXlJR3JZVnlOT3d2SENCTW1GcUsv?=
 =?utf-8?B?cDhYRU9oWXlFU0VSbXRCbkJUL3VHZENMaE4ydEZ0a1NDNTFrNThNeStqVVli?=
 =?utf-8?B?d3JxaUs3MFhaZlAxRG96S1I4UkFUVk05TUhVVXQzRW5jdjl0elVUdFI1SVlO?=
 =?utf-8?B?REZadUVmYTlQYU9JWExJb1BvSHRnelRUQWVaVm45Y0NIV3NTL2I0bi9zN1Qw?=
 =?utf-8?B?b281Z2VKbm03U3RGbFd6NTZlUVlsYjBhd2kwSC9CMnI4TjRkajBnS3hvWGJH?=
 =?utf-8?B?QTVwT2t3OHNjUTdnK1p4Q0UrSFRNeXdjaitoekpoOXBxS1RKZVBZS00xY3N0?=
 =?utf-8?B?WDZMWlo1bTVMb09yNXFwQ2RtWjVqSGIxRVZqM1RhVkRXWm5Bd3dLLzhhb2Zp?=
 =?utf-8?B?eGdtbVJndjFPeDVSeU83b3B5U0FMUUd6NVRTWEVKS1hPM0tNV1JtTzBaU0lJ?=
 =?utf-8?B?NFhhZkxBaERQL1NFL0JzSEg0Tmk5a1o1dk54RHA5S2FBQU5FNzdsZGZib0tB?=
 =?utf-8?B?TU5EbUZyZFZtQmpHY3l0ZWNRUU5oNDNWRHdwdGVEOU5aZUUzVG04RlNPeXdu?=
 =?utf-8?B?Qyt1RjZVYnFZUm5UTytxVWZJUERjS3doOE1UREpUamtnMjEzT3dlRCs5dHR0?=
 =?utf-8?B?ejN3bW8vbUpPbU50VWhLMjNXVzFWNlBrdGh2VGRuRzNVbHZzRmhQT1FlS0h1?=
 =?utf-8?B?VmxZVVhtZFNqZmw5S2I3R2U5d2lEVXV6c2RsM1EySUgrY3NxcEVxUWs2ek5U?=
 =?utf-8?B?a1FoaXpMTXQwNUFXMWZ0TTVHR0FxbGZuVER4T1hxbEhSTHNZK25vVWFLZGRs?=
 =?utf-8?B?WjB4eEJQYy9TVVoyK1hnWXlrVCtsdm9mT3FmY2VlbGE2NUNvbFRKOHZRR1ZQ?=
 =?utf-8?B?WUZLRnRqSk9pVGlkR01NY3E3NEp4dkY2b1BQbWcwU0lNTThuSEdROS9MVjB3?=
 =?utf-8?Q?PyME=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57363a90-7cc5-470f-32e5-08db7dd84559
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 04:20:03.2621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v7uoOpYR0GX/KcoDvriJLwup/5cIVBOkV5zjtpkMa48hrc6w2lg1qELzJxyTao2dvXzMJyTk3rG6yCgIo01jpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8056
Subject: [virtio-dev] RE: [virtio-comment] [PATCH v9 0/4] admin: Access legacy registers
 using admin commands

DQoNCj4gRnJvbTogTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4NCj4gU2VudDog
V2VkbmVzZGF5LCBKdWx5IDUsIDIwMjMgNzowOSBBTQ0KDQo+IE9LIEkgc2VudCBhIGJ1bmNoIG9m
IGNvbW1lbnRzLiBQbHMgdHJ5IHRvIGFkZHJlc3MsIHVuZm9ydHVuYXRlbHkgSSBkaWRuJ3QgZ28g
aW4NCj4gZGVwdGggb3ZlciB0aGUgbGFzdCBwYXRjaCwgYnV0IEkgZmVlbCBpdCBzaG91bGQgYmUg
c3F1YXNoZWQgaW50byB0aGUgZ2VuZXJpYw0KPiBsZWdhY3kgY29tbWFuZCBzZWN0aW9ucyBhdm9p
ZGluZyBuZWVkIGZvciBpbmRpcmVjdGlvbiwgc28gcmV3cml0aW5nIGl0IG5vdw0KPiB3b3VsZG4n
dCBiZSBlZmZpY2llbnQuDQoNCkkgYWRkcmVzcyBhbGwgeW91ciBjb21tZW50cyBhbmQgb2YgQ29y
bmVsaWEuDQpQQ0kgcGFydCBJIHN0aWxsIHByZWZlciB0byBiZSBzZXBhcmF0ZSBzbyBrZXB0IGl0
Lg0KDQpUaGFua3MgYSBsb3QuDQo=

