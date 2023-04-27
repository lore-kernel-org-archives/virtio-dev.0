Return-Path: <virtio-dev-return-12456-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF6CC77B61
	for <virtio-dev@archiver.kernel.org>; Thu, 27 Apr 2023 20:31:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9C0EA33096
	for <virtio-dev@archiver.kernel.org>; Thu, 27 Apr 2023 20:31:18 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8C79798667C
	for <virtio-dev@archiver.kernel.org>; Thu, 27 Apr 2023 20:31:18 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 7B700986673; Thu, 27 Apr 2023 20:31:18 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 62C9E986674;
	Thu, 27 Apr 2023 20:31:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eW3lc7gVLVTNczmdaJpohIBYTAU5EWNkjT+iZpS42AEvuOyxRVNDCH8jhVqK/eQD+j5ioEamFlDkXYWsgIc8bkzxeI5GupGXT04eBK5/gl3kl/Qwe3qE9qUv/5GichwHpZxhNoyCowSJJQVY/G2mSc2WDi2P15jplQsZPdqmwQ1pfGmUtooUfqnjmEqAfqskRGpjRk1MB+g9tH3bDHqLA9wMn3CXNfZyTdrC8+kCbKhHGgisH747NbSMMMpOgzlKBTwAI5V0KgW7df6o20OnMbHhFjgrSqbXUEaDSpVdjrr5Q1T7AqxI36NkqdSrtPZat1FThH3Ah21aeU6nhC9QpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YdxKWXcFCtBnKahesXouuIgPGirrPAtnlp9K6JpOgb4=;
 b=BQDJxe5/7c2qyW8M+W8NfI1gqu718wpfLNUpGY3hW2gz/E2GDlU5fCZK3amMy+5rcw2a1Vr8Fhw92Iu3zGAeV0qG3XA8aHfEKVlPWh1PlzZN5lAO9oy8EZWVGCi7mX8aYMpKxR9AdJNl1PJcdIf9kboX/ajtpIQ2+6Mfinayy0Azm8tzjLfA0C4ve9obwumpc7s9kC/wAvfUjAdptZCZaKupxydqVUyq0YrnlgZ845RyhjNKJPZkRzMhYl6yn/tc0hsz1Eizn52eyLsWbqiduvt1aRkfS2FSCrGjoljI02o4CpEv6hA12x5wp/dXr/ohIFT5F4UpGQuQd+fvTA3dIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: zhenwei pi <pizhenwei@bytedance.com>
CC: "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"helei.sig11@bytedance.com" <helei.sig11@bytedance.com>, "houp@yusur.tech"
	<houp@yusur.tech>, Jason Wang <jasowang@redhat.com>,
	"jiangzhuo.cs@bytedance.com" <jiangzhuo.cs@bytedance.com>
Thread-Topic: Re: [virtio-comment] [PROPOSAL] Virtio Over Fabrics(TCP/RDMA)
Thread-Index: AQHZdzNBmtt9WVKT+0+UqhnowhY2Ka8+0+AAgAC9tLA=
Date: Thu, 27 Apr 2023 20:31:13 +0000
Message-ID:
 <PH0PR12MB54818E051102FDC9281F2DA0DC6A9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <1ab0beff-8b18-7a94-1a68-6bf36bcd0394@bytedance.com>
 <CACGkMEvh+G2Tm=WDTOK3K2GO8c2dQ4y=UiKAk_kvsid2MGzbGg@mail.gmail.com>
 <8f65c9aa-c867-0929-151c-21bbe25a0693@bytedance.com>
 <4150bd72-a358-c854-0c64-b149621a1b8d@nvidia.com>
 <5af40945-9f11-93f8-bd2b-3a795d13f06c@bytedance.com>
In-Reply-To: <5af40945-9f11-93f8-bd2b-3a795d13f06c@bytedance.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DS7PR12MB6287:EE_
x-ms-office365-filtering-correlation-id: 34554ba5-c74c-4ba7-f60b-08db475e5881
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 AndYo3egeuvfx78PWEb/eEqBLrdnOf9lRyfmW3NpYRx/63u/hp8nVnz2efC8+/T5sGaM9f6MUzMZnucTQLgofEoxjUTWL+hvXW13gZVWFDosYJ4QQ2fBggMk2AkiQj52YMsrzee0Q2ZwzrkYch5XLvoNwFRoFumYJvsQ3TSjnS70uL1W/zr8d6j1thrPQu6CqR5sayQPq/gkQzazPoArIgO3s+d9vAHMQ0Y3EBj+kitA9I2miJ+lfcoh61X1mgX/Hlcz2TQLlgjnFOD9KAB4t9Nw3HZoKnNbXoq3ofMArbykineNMgmjL9Z5cnUTbCm+tz29yza5A+no9q9XZmTHcuSGKt7NDplw5V8ZkOsIpf+dPDcvZ+JhawhHBVhF+3Nc8HR9vFg7RTC5Ch3GOIYCD6Nhx9yO1k8CjajkuK17DAZu7pqf1LmIj+1FZEGOczeTLnLZZ7moLtwnPt6gd/9Mt94MZ3LNO+TUV9J9XzachhsLOlhsvhqxIakCbti8G/Q4SgSj2qg8lY0wJg8kk8iIVYRSRRdEdHnZQ0O3AfNxlTbeRA49RSWcWuiMqR2vuzWZdyM4EJdIySSblQJaZxrqLaWEF9tREKQtgUTbKMGnVHExk1ONz+oaiXxdVmwcwukq1ib1dVpmfQxzEQ+kqHIb/NmNKzI+ujiyCld6clj7zftcJdG1MO8MdgNL3RrHO/ai
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(451199021)(55016003)(64756008)(122000001)(66446008)(76116006)(66476007)(66556008)(66946007)(478600001)(4326008)(52536014)(8676002)(54906003)(8936002)(316002)(38100700002)(41300700001)(5660300002)(83380400001)(53546011)(966005)(186003)(6916009)(6506007)(71200400001)(26005)(7696005)(9686003)(38070700005)(33656002)(2906002)(86362001)(200143007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VkYxMzcwR3phdnNUUHAvS2tOODU2OGdlaVEzV254c0FUWDVyb2dJaU9ZSlFI?=
 =?utf-8?B?Y0hUT2pVdkVoMGR2ZDNXWjNPRno3T29vTGpQcmRTejUvTHREdUROQ25OQnRP?=
 =?utf-8?B?U3ZaQmYxU1dQOXlLUGo4ZmlyWkRJTkVXTzV5Yzllbzk2QXpsdy9HTENHajJ4?=
 =?utf-8?B?RlJjbWIvbDZoY3lBc1JQb3NrRHE0V0doQVBaUklZRDVPcU5vbEYwOHJRanJT?=
 =?utf-8?B?SFYzYldKaWFydEF5SFM0ejc4amNIWS9wYVBxd0k3ZEd5blZiTGV0V2lSOU5j?=
 =?utf-8?B?dkpkb1dCdXdKUytzM01LckpQRDhGUDQ4Zlp2R2N6dEY0MmFNYmdWZDQzbVpN?=
 =?utf-8?B?QWJqa0MwKzZIS1RycFJrNmxqTzlaOXhHS3EzWTBMaEpyRnNLa3NyNDBGZkhs?=
 =?utf-8?B?OG5IUDh4RnA4eExDU1QvcDZleHdzL0g5RW9iRXdjTU1KMEVCTFh3ZUliNmVY?=
 =?utf-8?B?aXd5eEZndngxOUVjVE1scXJWSjBCQnBiU2ZrV09yMm1MTFZMalA0anhRNG9V?=
 =?utf-8?B?aG5KVzNmYXk2UGVXTXdoZUMvM2ZhdEhVYUlCLzdnUWdkejhCR0NKanVOUEVS?=
 =?utf-8?B?KzBKb0o4bzdTWlVtTCtPYXlaOWdwTUdZaGdVNmFHTjRlaUZiR25RMHp4WElz?=
 =?utf-8?B?MFNuRVJBdlc3Z05EMTBHVmVHem8ySFBuRTVnSStudUtiSXRWenVWWXRjNVlF?=
 =?utf-8?B?c0tKYmJ1UHVEVFhPMlBMS0Vjc3h3aElabmFVS3daeFpSc0NFK1BOMzNoNGVl?=
 =?utf-8?B?QW5YL0UzOUpMUHFWa2M0ZjlCMnJRRzI4Ly9ZOTd3bkdWL2F2c01uZlBJRi9n?=
 =?utf-8?B?S3BMU3NtZ0NXenRCUUJkUEhVN3ZmUDdBMHdEZUY2dXRPSXMxVFltcWZmYkVJ?=
 =?utf-8?B?OXJCSmZTOHhKMmZBbm12RHpZdVVHbkZhejl2WXVxKzdQcy9vUmVUT2gyU2c1?=
 =?utf-8?B?VTFUWmlRc1FNc0NsQnRFa1l0cjVCTVo3RnRZY0dzN2ZGOGlIR1B1akI1U1JQ?=
 =?utf-8?B?OFF0akUzdTBlKzVUaWVoeUJtcDhDY3hNdmZ1NWxpWVNBemJ4NnBRWVVBajgz?=
 =?utf-8?B?R0J6a2NaT25hWmNGL1RYdmp0ZWU2NWhqSXA3MzJEKzlYbGMzVW1wU01VOE5D?=
 =?utf-8?B?T3kxM2FUV01JT05RcEk0N3JzdmUwbHJmckQxbyswZDIxaGJOTUtNRStuVDJh?=
 =?utf-8?B?OVdHTkhZUUg1aHpLaUozbjVmQzZLSHBwUGNIQnZWUWw5NmtzYTlVeFlvckdh?=
 =?utf-8?B?bUJKMWJjY1dXQndhVXRIUXhUSTZ5aU1RVlZwRUQyNUppYm1iZmN0a0hwZUlK?=
 =?utf-8?B?bUhmNHArV1FYdEFoTWFqQWNESEllbWFEclNQRml3dDE0QmFFdTJrK2RUbDA3?=
 =?utf-8?B?bDFLd0tlOE56NGtYZzZXbmE4MmxGeU8zcCt1QkdsbjRsNExqbFBXOUErb3Nw?=
 =?utf-8?B?U3NGS1FpM0N5ZUpNZ0pVQjJsd25jdU9LeXozdEljMTBKb2hXSVpvRlZEd2FB?=
 =?utf-8?B?SnZRN2RRTHdTTEFGdC96QS9mc0lqL2szVTN4M0ExTlJOMnBNVUJTNE0zS0th?=
 =?utf-8?B?cDEvY1dieEhKKzlyclFxTysrTnFnaVFCdXg2aVVUTjZpalJlNThmdE94aUQv?=
 =?utf-8?B?dU1hOW11Nm5GcGp3YnF0SjBhWVQweG1xeUpQS1BGeHRXQUNpaFh1Tml0bTMw?=
 =?utf-8?B?c0VrcWs2ZllUUzVsYmhRdEQra1hXZWN4VExOWkxMTTVpZTl5QTJ5aXNPY2FQ?=
 =?utf-8?B?Y2dvZnFyRFNlL05NU3RvTHl2eVBVc1EzazZocHNEMEVPc0xKa2VqdnZ2QjlM?=
 =?utf-8?B?bkk0c3R6N3ZKUmcvdERrMW84bEJRU1ZwMG9iaDJrWmlmWjBlSmhpWEdHemdM?=
 =?utf-8?B?NWcwSFh5SUJuTmh4aEwvWFkwU1FLQ0F5MWhJLzJjVHF6U25ibXppY0ZTSXpC?=
 =?utf-8?B?cjh6VldpL01hY0pZTnV5ZEtXbEdIVkFVYkJoNmtxZGhSeTZQK1YwYWhpS1U5?=
 =?utf-8?B?TC80MWdySVpLOVhUeHBpVjFHT29KMGx0NGMwZnpIT2xwaVRsSjN2NTk1MkFh?=
 =?utf-8?B?ZzUxQWdPcHhvQVRzME9JUzN1QmtWWGZ2OEFtVXkyaFJ2YjZxZ1p5dUk4Y2Z2?=
 =?utf-8?Q?cy0o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34554ba5-c74c-4ba7-f60b-08db475e5881
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2023 20:31:13.9926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7tmgwhwI64nSCMsowbPBfiZHC6g6scuY7TL4H/CysjUH+vXZ2r2bkL7gKX91l8jOzJPK3MNnsiT7ClkWQUxE7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6287
Subject: [virtio-dev] RE: Re: [virtio-comment] [PROPOSAL] Virtio Over Fabrics(TCP/RDMA)

DQoNCj4gRnJvbTogemhlbndlaSBwaSA8cGl6aGVud2VpQGJ5dGVkYW5jZS5jb20+DQo+IFNlbnQ6
IFRodXJzZGF5LCBBcHJpbCAyNywgMjAyMyA0OjIxIEFNDQo+IA0KPiBPbiA0LzI1LzIzIDEzOjAz
LCBQYXJhdiBQYW5kaXQgd3JvdGU6DQo+ID4NCj4gPg0KPiBbLi4uXQ0KPiA+DQo+ID4gSSBicmll
Zmx5IHNlZSB5b3VyIHJkbWEgY29tbWFuZCBkZXNjcmlwdG9yIGV4YW1wbGUsIHdoaWNoIGlzIG5v
dA0KPiA+IGFsaWduZWQgdG8gMTZCLiBQZXJmIHdpc2UgaXQgd2lsbCBiZSBwb29yIHRoYW4gbnZt
ZSByZG1hIGZhYnJpY3MuDQo+ID4NCj4gDQo+IEhpLA0KPiBJJ20gY29uZnVzZWQgaGVyZSwgY291
bGQgeW91IHBsZWFzZSBnaXZlIG1lIG1vcmUgaGludD8NCj4gMSwgVGhlIHNpemUgb2YgY29tbWFu
ZCBkZXNjcmlwdG9yKEkgZGVmaW5lZCBpbiBleGFtcGxlKSBpcyBsYXJnZXIgdGhhbg0KPiBjb21t
YW5kIHNpemUgb2YgbnZtZSByZG1hLCBtb3JlIG92ZXJoZWFkIGxlYWRzIHBlcmZvcm1hbmNlIHdv
cnNlIHRoYW4NCj4gbnZtZSBvdmVyIHJkbWEuDQo+IA0KV2hpY2ggc3RydWN0dXJlPw0KDQpJIGFt
IGd1ZXNzaW5nIGZyb20gdGhlIGhlYWRlciBmaWxlIHRoYXQgeW91IGhhdmUsDQoNCnZpcnRpb19v
Zl9jb21tYW5kX3ZyaW5nDQpmb2xsb3dlZCBieQ0KdmlydGlvX29mX3ZyaW5nX2Rlc2NbY21kLm5k
ZXNjXSB3aGVyZSBjbWQub3Bjb2RlID0gdmlydGlvX29mX29wX3ZyaW5nDQoNCmlmIHNvLCBpdCBz
ZWVtcyBmaW5lIHRvIG1lLg0KSG93ZXZlciwgdGhlIGxhY2sgb2YgYWN0dWFsIGNvbW1hbmQgbWlz
c2luZyBpbiB0aGUgdmlydGlvX29mX2NvbW1hbmRfdnJpbmcgc3RydWN0IGlzIG5vdCBzbyBnb29k
Lg0KU3VjaCBpbmRpcmVjdGlvbiBvdmVyaGVhZHMgb25seSByZWR1Y2UgdGhlIHBlcmYgYXMgaXQg
aXMgbm90IGNvbnN0YW50IHNpemUgZGF0YSBjb21pbmcgaW4gZm9yIHRoZSBibGsgc3RvcmFnZSB0
YXJnZXQgc2lkZS4NCkFuZCBldmVuIGlmIGl0IGNvbWVzIHNvbWVob3csIGl0IHJlcXVpcmVzIHR3
byBsZXZlbCBwcm90b2NvbCBwYXJzZXJzLiANCkNhbiBiZSBzaW1wbGlmaWVkIGFzIHlvdSBhcmUg
bm90IHN0YXJ0aW5nIHdpdGggYW55IGhpc3RvcnkgaGVyZSwgYWJzdHJhY3Rpb24gcG9pbnQgY2Fu
IGJlIHBvc3NpYmx5IHZpcnRpbyBjb21tYW5kcyB0aGFuIHRoZSB2cmluZy4NCg0KSSBkb27igJl0
IHNlZSBhIG5lZWQgZm9yIGRlc2MgdG8gaGF2ZSBpZCBhbmQgZmxhZ3MgdGhlIHdheSBpdHMgZHJh
ZnRlZCBvdmVyIHRoZSByZG1hIGZhYnJpY3M6DQpXaGF0IEkgaGFkIGluIG1pbmQgYXMsDQpzdHJ1
Y3QgdmlydGlvX29mX2Rlc2NyaXB0b3Igew0KCWxlNjQgYWRkcjsNCglsZTMyIGxlbjsNCgl1bmlv
biB7DQoJCWxlMzIgcmRtYV9rZXk7DQoJCWxlMzIgaWQgKyByZXNlcnZlZDsNCgkJbGUzMiB0Y3Bf
ZGVzY19pZDsNCgl9Ow0KDQpXZSBjYW4gcG9zc2libHkgZGVmaW5lIGFwcHJvcHJpYXRlIHZpcnRp
byBmYWJyaWMgZGVzY3JpcHRvcnM7IGF0IHRoYXQgcG9pbnQsIHRoZSBhYnN0cmFjdGlvbiBwb2lu
dCBpcyBub3QgbGl0ZXJhbGx5IHRha2luZyB0aGUgdnJpbmcgYWNyb3NzIHRoZSBmYWJyaWMuDQoN
CkRlcGVuZGluZyBvbiB1c2UgY2FzZSBtYXkgYmUgc3RhcnRpbmcgd2l0aCBlaXRoZXIgb25lIG9m
IFRDUCBvciBSRE1BIG1ha2VzIHNlbnNlLCBpbnN0ZWFkIG9mIGNvb2tpbmcgYWxsIGF0IG9uY2Uu
DQoNCj4gMiwgVGhlIGNvbW1hbmQgc2l6ZSBub3QgYWxpZ25lZCB0byAxNkIgbGVhZHMgcGVyZm9y
bWFuY2UgaXNzdWUgb24gUkRNQQ0KPiBTRU5EIG9wZXJhdGlvbi4gTXkgY29sbGVhZ3VlIFpodW8g
aGVscCBtZSB0ZXN0IHRoZSBwZXJmb3JtYW5jZSBvbiBzZW5kaW5nDQo+IDE2LzI0LzMyIGJ5dGVz
Og0KPiB0YXNrc2V0IC1jIDMwIGliX3NlbmRfYncgLWQgbWx4NV8yIC1pIDEgLXggMyAtcyAxNiAt
dCAxIHh4Lnh4Lnh4Lnh4IHRhc2tzZXQgLWMgMzANCj4gaWJfc2VuZF9idyAtZCBtbHg1XzIgLWkg
MSAteCAzIC1zIDI0IC10IDEgeHgueHgueHgueHggdGFza3NldCAtYyAzMCBpYl9zZW5kX2J3IC1k
DQo+IG1seDVfMiAtaSAxIC14IDMgLXMgMzIgLXQgMSB4eC54eC54eC54eCBUaGUgUVBTIHNlZW1z
IGFsbW9zdCBzYW1lLg0KPiANCnN0cnVjdHVyZSBbMV0gZ2VuZXJhdGVkIHN1YnNlcXVlbnQgdnJp
bmdfZGVzY1tdIGRlc2NyaXB0b3JzIHRvIHVuYWxpZ25lZCA4QiBhZGRyZXNzIHJlc3VsdHMgaW4g
cGFydGlhbCB3cml0ZXMgb2YgdGhlIGRlc2MuDQoNCkl0IGlzIGhhcmQgdG8gc2F5IGZyb20gaWJf
c2VuZF9idyB0ZXN0IHdoYXQgaXMgYmVpbmcgZG9uZS4NCkkgcmVtZW1iZXIgbWx4NSBoYXZlIGNh
Y2hlIGFsaWduZWQgYWNjZXNzZXMsIG5vcCB3cWUgc2VnbWVudHMgYW5kIG1vcmUuDQoNCkkgYWxz
byBkb27igJl0IHNlZSB0aGUgJ2lkJyBmaWVsZCBjb21pbmcgYmFjayBpbiB0aGUgcmVzcG9uc2Ug
Y29tbWFuZF9zdGF0dXMuDQpTbyB3aHkgdG8gdHJhbnNtaXQgb3ZlciB0aGUgZmFicmljIHdoaWNo
IGlzIG5vdCB1c2VkLg0KRGlkIEkgbWlzcyB0aGUgaWQgaW4gY29tcGxldGlvbiBzaWRlPw0KDQpb
MV0gaHR0cHM6Ly9naXRodWIuY29tL3BpemhlbndlaS9saW51eC9ibG9iLzdhMTNiMzEwZDEzMzhj
NDYyZjhlMGIxM2QzOWE1NzE2NDViYzQ2OTgvaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19vZi5o
I0wxMjkNCg==

