Return-Path: <virtio-dev-return-11668-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B57C76195
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 04:20:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 44EC541F0E
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 04:20:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B5B4F986475
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 04:20:27 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3124C98642A; Tue, 21 Mar 2023 04:20:27 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8430E9863AC;
	Tue, 21 Mar 2023 04:19:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yof9byWiy4vZ/MIw7OZGQCch2WEKWEdg7LWS4gt78DXhl/ruFK3EtrMMfoCyXUOjE99mlyzNyvRXs6zfKv4MOWhFxXZU87B8TNNxYg27GhzotAZgSWVaL8XPqQr1E+LVGi5y4rMxx2JeMPxQbc7aBNshp320QRDc5PiUZbiNiLhXwaET2pp7BgTJ/265OtUmkEbJvdOFmWxze3gFx1eZlKGkkDHN9ChOimEKeQ7eQNZy0qJ8d1SobFWbkp1GyUz18YJnrNDYezVqfNwvbB+vckVzSRMI0qRSHUcsVIwBiiIskzi8z24V/gkyDm06KTOOq0EEzaqefuV0QJBoctcJEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64RqjcUZqmA8NI59w3G3dRSZZvP2UAfqRCulNGPvX+k=;
 b=WqKZMJ9Yl3vJRm26UrqUnTB287PwacZaQv43ZYzlV5LGmZ7BD1YCimGRGm5k2dWdG3xoXQIa5Dfmlttccc3T2Z/nIqSpQcj2V9XdBr2i8wG2BZgNQ7U6O9xrvSGvGG53wTTjusix+cjqKlaHSOIOldh6v3EyJpkCBO+pBU2kdleD41xmxNmqQcvWBKSnhUTrJsH0WgSxOP+OmCf3wAWke/5kJ1WlZjvBtv8cuFypIKc3t8VK3mZzRMGCH+n9oIXl+l0Oz6Wr/onzmIWz7fL5t/rVVQH5BwpqIhXqhSyeUtHS7fXQKJdsylqURADik7uZ49Unpm69AC4V04ih1uPLWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Heng Qi <hengqi@linux.alibaba.com>, "Michael S. Tsirkin" <mst@redhat.com>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Jason Wang <jasowang@redhat.com>, Yuri Benditovich
	<yuri.benditovich@daynix.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Thread-Topic: [virtio-dev] Re: [PATCH v11] virtio-net: support inner header
 hash
Thread-Index: AQHZWx29SoEdHy2EykmUgaDSd+Xmwa8EEleAgACJlwCAAASCAA==
Date: Tue, 21 Mar 2023 04:19:17 +0000
Message-ID:
 <PH0PR12MB5481C6A8454381F508A30387DC819@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230320111840.64039-1-hengqi@linux.alibaba.com>
 <20230320144625-mutt-send-email-mst@kernel.org>
 <3a1969e7-2c4d-b64e-33b2-57311d73fb45@linux.alibaba.com>
In-Reply-To: <3a1969e7-2c4d-b64e-33b2-57311d73fb45@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DS0PR12MB7778:EE_
x-ms-office365-filtering-correlation-id: 0e3e555d-237e-4abf-9194-08db29c36fb5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 zeQy4cPBT11TAHdVzzz+yVFlkyvbnDe1gjzpJaFBPv4Zkhks/EQn7cw27G7dDKyf90LKdv+bauLyHd/oGKjKrUYtmwQdecm7grvszbzk2EIOmSYWKCYl9F3Nt0t5C65bL6AqAkwxbKimGiVcvru4PuZcT1mdIZsiYf8FUFhQryAhz93iUm3XtPMruAI4bzTfVBABmHBKcKZzzB/1UfR3TdC5MXAe0KDSs8/3c1opuhfXdkVKVP9eozPDVBmerNDot7p7DwFVPh7iLIOVZhjpWRBp5O/TqCxgeK+SjbjUZCR3tJDTSG1HIKJV+qIUwmT0R36igAS31/cFxq3zRyd/o6vY198Z5Y9vVqjqB+cVk5RaeswNmp86+FbLLJZqLK485Z1mCIITXaTqNiEmHukhlG4abQxurvPb3KV1sCFxujFPK8SD9Qwt7IxQMT9ZCY9dyrxREFJIlkImItrEp+EXX7RFDRdP+zakaSvnUTDEaryQy65kX7Qi3wh82JReNBom7EcxtefSVvIY4hYlTYD3UgsZkHMmDv1djk/0Tj1ZXkDHvM48KgB8/OnK/3GXNSrHCE3e15ts20P+/QMjwHHTY9fjW+x5JnexcL6o1B0fS55PVeKHRN6NLIo2QYhenb7GyBZSqB1N7AeemcXd7/YcYR5Ul/5/ZeY0TkcdSRqn8a+JJ3nhaxvF93ylAEB05zGTuyZWqa7aRUQPJf8mJXE7yw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(451199018)(86362001)(55016003)(33656002)(71200400001)(66556008)(64756008)(316002)(4326008)(76116006)(66946007)(478600001)(66446008)(8676002)(66476007)(186003)(54906003)(9686003)(26005)(6506007)(110136005)(38100700002)(38070700005)(7696005)(8936002)(5660300002)(52536014)(41300700001)(2906002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SHJuWmVkK2RleC92U0YveDduL1RwaHhPSExnaDVua0FYbC9ZSVdKMW1XRVJo?=
 =?utf-8?B?RnNNWFZValBUMDNqckVLWFVlV0RhUWZJcmYxb1dNa2k3RHl4cWtLeE1hbytR?=
 =?utf-8?B?cUtvMmFIakw5VGZNQUQxS2FRVnBxV2MvMGMwdEtxcnhLY0lkNDIwSzFKTXFH?=
 =?utf-8?B?bi9kR21TRmdXSWU3MEt5UHQvU0hVSzl2R08zZXFJdXV2dzVRU2NVMkhLSUFw?=
 =?utf-8?B?cnA1N1daSmhDY3Vmd2IzNTk5THEwMkdCdWVDK0IwOE5IRHc0Tm9UTy9tblRv?=
 =?utf-8?B?cmtURDdSWUN3bGRxYmY3blZ5ZkJMVm1tSlR2MVFyamowdndBcDFWZVZGb205?=
 =?utf-8?B?WVQ5QWw0V1BneHRWYVFwR1B0cEY0ZEFQaExzK2ZLRzcxdXl6NDhxZGp4dzRU?=
 =?utf-8?B?aWFiWnVKRE5zR1lISjhLbUJQaEkvbnE4YzlZMUFpZFZ0SmtYMFArYjBUanFm?=
 =?utf-8?B?VlVUUCtWM09KYzdaZmJIcWVSN1lFdDVneEJqcUR4ZXJBUTNPUUNkUDNKcmx1?=
 =?utf-8?B?Z2VWTjQyVmd6dW1MSWxUS0RkcU04SERvQXFBZ3J0Q3FjLzB6dFhNc0NDaDVM?=
 =?utf-8?B?WVZRQ0Q0d2grTFR3WnhXR200dm9BNTh2TUo5aExmclN4NWtpTE51VzkzTUxI?=
 =?utf-8?B?MWRBQ3hwQmh6Rmowd05wVUt4UlhES1lTQjFmb012QXk3U1dkdm51V3lDK3lT?=
 =?utf-8?B?VEhKVlhhbGdlZ3lndjYwTE4wSXZDZlBLQkdGRHc3ZlBZOVYwRHNRR0VlK0Jw?=
 =?utf-8?B?RStBWWIraFltOTZaaUVtdHVhY2xMZ0ZzcktNVWltTVVQQW5rS0NYM1lBa25O?=
 =?utf-8?B?dUI0eTNaSERSdThUOWpJVFlyczhwZDJtdmVsakU3ZU0xTTgxSTVtT0lCV0dX?=
 =?utf-8?B?MG1RaEpGMXJmOVFwTkpwMHJqYWJkUHNsa1Y1ZDM2amFIYkh2NDV2ZDVkYTJm?=
 =?utf-8?B?TDJWOG1mMnhta3BKYmt6Nk93Y08zMloyclJaOVdjWDMyNnphMzAzRW84cTVh?=
 =?utf-8?B?dUlrVm5XMXRNbVBma0I2bjQrbmQ5RmU2c3dLU294YWc1aDI4eWU1YXFxUkh5?=
 =?utf-8?B?aW1vTmZ3cUhObFE4SW9hWllySjJpNjE3OFg2SnhtVVhOMjhvN1FNQmFaVlc2?=
 =?utf-8?B?ak93eS9TbGtoY09TNytSczI5WnZTTENod1U4N0FRaWNGeGc4T1F4WWdXNEJm?=
 =?utf-8?B?dWs0akZiZFhlRkMvUG9ZYklZVlBJYnVIY1QxQlkyYWMxL1gxU3NuOUJNUzYv?=
 =?utf-8?B?Y1ZucHo1VHRZTVRjNS9rK2t3QStRc0xVUG9ETmpiNlcwelVHc2tTaVVpMVox?=
 =?utf-8?B?SDVCcmFMVFdFaW9VWElZV1VQZnZPblQ4UU1nbFJnNW5TK2ZVZ2p0VEkwWXhD?=
 =?utf-8?B?TjNDMTZ6TUpiN2l0blcyTjVtRjFrK1VCYmJxNkZFV3ZvQXJuRGkxOUN6MzNQ?=
 =?utf-8?B?ekQzYm5EQzVUdDhlWVlOMVZxWDJRTkhLbVhPaFhDbmkxM0NJR1hpM3Bmc2xo?=
 =?utf-8?B?U3MyV2Vib0RsR2Z0SVp5WVJqaU5Sb2JOaE51VlBSSnd2TlFKZnphN0pwL2hP?=
 =?utf-8?B?aU1YMmRHZWNHWmJ4U25zUmM5UnFaK1NIbkNpUXR3d0wvSWY2Z3Zwc1pwM1JX?=
 =?utf-8?B?bFRHYlR0UEFMY3lHL3h2aXBrbnkwaHhpV3JxdHNNQ012VXZ1ak40V2Jyb3pW?=
 =?utf-8?B?eHNIWFhoWUdiK3k0d214R0tuMXF0LzdtZFpqMGNieUpUYTNxOEJ1TVJrTE5X?=
 =?utf-8?B?dzYwS1dIVFpxLzBzOUtTWlZpS2xUL0FrZWxrY1FCN3ovUHpTNGZyODljU0dh?=
 =?utf-8?B?T09jUGh5Y200bDhwTHl1bjhYMHU3U1F1Q0V2Q2NkTE5xaVhyQmxBRXpWc1RJ?=
 =?utf-8?B?TW5xZXgxS0pLNzRrSFhTTG5EbnJwRERpQy9tT3l6UENNYzdpNlpGclF5aFI3?=
 =?utf-8?B?WCtsVWk3Q1d2bGxjc05lQW5jK1JPSGV6K3RVQ2ZOOUNmNDczaklUendaMTMy?=
 =?utf-8?B?Uy9yenNGV3l0S0hha1NnbjB4VlZxRDVlWkNLVW5xc0RZZHhsb3UvMFhoemVK?=
 =?utf-8?B?bXJLaHBFekxFdlkxWVRJQnNOOFNBRnRlQysxTnpQU0hwcmFkcUxLRHFYK2pl?=
 =?utf-8?Q?/VEI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e3e555d-237e-4abf-9194-08db29c36fb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2023 04:19:17.2120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pa6+oXUaahf9xTT8vbEUGKUKQkHdP4LdfaVM0RR5ELSHGGEQyx9nnh4rxfqumE1q8gUrqnEwkkqaOuc2xP5P6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7778
Subject: RE: [virtio-dev] Re: [PATCH v11] virtio-net: support inner header
 hash

DQo+IEZyb206IEhlbmcgUWkgPGhlbmdxaUBsaW51eC5hbGliYWJhLmNvbT4NCj4gU2VudDogTW9u
ZGF5LCBNYXJjaCAyMCwgMjAyMyAxMTo1NiBQTQ0KDQo+ID4gdGhlIHNhbWUgZmxvdz8gIElmIGVu
b3VnaCBwZW9wbGUgYWdyZWUgdGhpcyBpcyBuZWVkZWQgd2UgY2FuIGFjY2VwdCB0aGlzDQo+ID4g
YnV0IGRpZCB5b3UgYXQgYWxsIGNvbnNpZGVyIHVzaW5nIHNvbWV0aGluZyBwcm9ncmFtbWFibGUg
bGlrZSBCUEYgZm9yDQo+IA0KPiBJIHRoaW5rIHRoZSBwcm9ibGVtIGlzIHRoYXQgb3VyIHZpcnRp
byBkZXZpY2UgY2Fubm90IHN1cHBvcnQgZWJwZiwgd2UNCj4gY2FuIGFsc28gYXNrIEFsdmFybywg
UGFyYXYgaWYgdGhlaXIgdmlydGlvIGRldmljZXMgY2FuIHN1cHBvcnQgZWJwZg0KPiBvZmZsb2Fk
aW5nLiA6KQ0KDQp0YyBxZGlzYyBvZmZsb2FkIGZvciBxb3MgaXMgYSBiZXR0ZXIgY2hvaWNlIHRo
YW4gZWJwZiB0byBtZSBnaXZlbiB0aGUgcm9sZSBpcyBtb3JlIHRoYW4ganVzdCBkcm9wIGFjdGlv
bi4NCkl0IHJlcXVpcmVzIG1hbnkgY2FsY3VsYXRpb25zIGFjcm9zcyBtYW55IHF1ZXVlcy4NCkJ1
dCBzdWNoIHFvcyBpcyBvcnRob2dvbmFsIHRvIHdoYXQgaXMgYmVpbmcgcHJvcG9zZWQgaGVyZS4N
Cg0KT25lICh0aGlzIHByb3Bvc2FsKSBpcyBzb2x2aW5nIHNwcmVhZCB0byBkaWZmZXJlbnQgUlNT
IHF1ZXVlcy4NCkFub3RoZXIgb25lIGlzIGZpbmRpbmcgb3V0IHdoaWNoIGV4YWN0IHBhY2tldCB0
byBkcm9wL3Bhc3Mgd2hlbiBxdWV1ZSB1c2FnZSBpcyBoaWdoLiAoZWJwZi90YyBvdGhlciB3YXlz
IHRvIHNvbHZlIGl0KS4NCg0KRWJwZiBzb3VuZHMgY29vbGVyIHRoYW4gdGhlIHJlYWwgb2ZmbG9h
ZCBpbXBsZW1lbnRhdGlvbiBpbiB0aGUgaHcgZGV2aWNlIGF0IHRoZSBjdXJyZW50IGxldmVsLg0K
SSByZW1lbWJlciBKYXNvbidzIGdvb2QgdGFsayBvbiB0aGUgZWJwZiBhIGZldyB5ZWFycyBiYWNr
LCB3aGljaCBpcyBwb3NzaWJsZSB3aGVuIGRvbmUgaW4gc3cgb24gdGhlIGh5cGVydmlzb3IuDQoN
Ck9uIG1seDUgZGV2aWNlIGlubmVyIGhhc2ggaXMgc3VwcG9ydGVkIGZvciBJUG5JUCBhbmQgR1JF
IHR1bm5lbHMuDQpOb25lIG9mIHRoZSBleGlzdGluZyB1c2VycyBzZWUgdHVubmVsIGF0dGFja3Mg
d2hlbiB1c2VkIGFzIGZvcndhcmRpbmcgcGxhbmUuDQo=

