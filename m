Return-Path: <virtio-dev-return-13165-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C34A5EB64D9
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 21:32:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 35EA12ACA9
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 21:32:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2864198671B
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 21:32:29 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 181349866F8; Thu, 29 Jun 2023 21:32:29 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 034C1986677;
	Thu, 29 Jun 2023 21:32:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TGC0SNCNnoyRa+ufhNr34KBC47F3FUzQihxDlZQiOsxQwPJApBLS1TpGZEjbYeahWbg4WaAv34qexTvmSCY82foacWgdw4iBLZhf6352dGdpQMB+9akzBkg/WXjE+/dqLGj/avucWSHpHVSICe51oFJhcAjbgMLu5c8Zu11pcyxNj7MicqIHStUnO+mpNADuIJRILcKJPaGIl3bJWXvVJWQmOSRKFL59MhwLxbhUOWOQlmnKDQzYBn+qGVcIy8QKCkMkRyt8lHCB7Xwg8SQ/YLaxvw+uJqzlcnE+lFYWcLtptNVhFE5710EE6EXi431qPiy3KCBSYv9YipoxpFsSAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kaan2Q+3lzdX0VRHWLP8DW71WQyhZ1X0cSw6ZTAIY70=;
 b=TaddOG9IMWAdMwpo2B+OkOO2Ghsr2jv6/W708gYGdKSBDjvg3PpHgkq2h2aCRCtYn7tN36RjEOp1cnravABEctaQEF1ykBoP++vn2GTd8emVnLsQdNmhPKi3vp4NTW/Bit8ZOySY399rldNF2FJO/IEtfbZ6/e72MIqUXSqRqdPkk2MaRba/zZXmSOqrZrv9E1/gzv8HPBe7TQnScJg5AnoyRrXunnjVLdGQ+B+U34vILNgLsc5zJwSSSonNHO0gqwgreNJd+ouZohv5dnQxrrEmdobTW9qlo3G6YQ8Q1DeV5xJDcULBMgc5Ip1CrxJqGllFX83BxpJsNoIjDvmRSQ==
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
Thread-Topic: [PATCH v7 3/4] admin: Add group member legacy register access
 commands
Thread-Index: AQHZqTvrGu2WS2SUoUu7prURQx0ADa+iM1gAgAAbrdA=
Date: Thu, 29 Jun 2023 21:32:21 +0000
Message-ID:
 <PH0PR12MB5481E7610F4941C615617CA0DC25A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230627211050.1527507-1-parav@nvidia.com>
 <20230627211050.1527507-4-parav@nvidia.com>
 <20230629154634-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230629154634-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MN6PR12MB8567:EE_
x-ms-office365-filtering-correlation-id: 0e3ed2e2-14cd-4677-be35-08db78e852d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 4/FF5j/R6TDXx8bxry02O3SDLYMfGRtn1E+KTISalYCIrJc3Q2Vs2npvEbyAQ0m42+aJAZELpRVrvETUnuWiCp/HkDe1eEVmjt6UCqd3ZUTDBK28Snk/H7HBB09vlZ4f91FwzjtnBLFEl5vOLF2Sol/ePikHYA/Hk9yKE1yID9VZ/hQDrAE9uL3aysWfJOgkvbulUaDHvOTFjEhPBscy45/pafZnHGlJI2fHjvgSd/qVfBTbYexHmCfL0TuZcmZl0FAzrYyUpA8mgU+l2wA275cSXfoik5xWuMVD5ZXNs7Q3slq4AM6oLMTPR/ZH+uIj6lPydTva1mF5ry/EThaNUHkjMdoolLuSDyB0kuam1PE1fbwxxo4mnG40D+P91ygUb0nY+rI3Xv0yM4CZ4pWkz1CX8yFO4voI7ID9d3Sj8I1kYK2GU08vbqUCflgWw9+YgYf7sGc+EYsb3Tj6/qwGmPZgdcfeIzfrwJ/am/hX/PSgNQXgD7PArwvKjGtwPdV/82PsmKFG07IRHwwxsC+V0LuWcJipC53t2osJIB7Qu5OddObfe1lNhOefiUXW06+f4PkQpfC0ZtWjuvxXBJWZLWAZ+mMahiejibdUs1zY9TRfjsTkcsHVby6WQB3t8gGw
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(451199021)(4326008)(66476007)(66556008)(38070700005)(107886003)(6506007)(478600001)(7696005)(54906003)(71200400001)(83380400001)(26005)(186003)(9686003)(2906002)(66946007)(76116006)(5660300002)(52536014)(8676002)(55016003)(38100700002)(64756008)(33656002)(6916009)(86362001)(122000001)(8936002)(41300700001)(316002)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NkY1bkxQUmcwWURUOXU4N2FTUmVOSEJzaVhRWWQ4ajN2bUgwUFZkVitVSVdK?=
 =?utf-8?B?VUtrZ3oxWHdQd2N5aWJ3UzlOdU5Ma0tVcVhmK1Q4NVgxalBCQlZ0RUYzWE5h?=
 =?utf-8?B?ckw3YmdNUUVubElJNWVTMHlQWXB2cWFqWEFOeGY4REF3bWNBNnpwdkRoV2tn?=
 =?utf-8?B?cmhsSU1pZnZtdGxFVFRreU9vaXpWUjBTRVdTbWE2RWxUQ1hXZ1dCbVpBSGJR?=
 =?utf-8?B?MjVTeFlHVTROa3g5UmsvNStHTVFOWUVUUkhkTG5mK3p3WnhiNHJLU3Z1bVhp?=
 =?utf-8?B?bTc5VDI4L3ZvQjM4K2xTdW14elB6dnp0RmcxOXIrNE1UZTVPa281Q3RpS0Z4?=
 =?utf-8?B?RUhMb3RtempYdDk5b3lQMlpPT0RTWkdUTjlIbHI5Slg2QjVDWW0zeGx4TzR2?=
 =?utf-8?B?RWZPTDJHYi82bzJEU2h5MWlzdEVOTkUwM05Ec1hTYzZGSmVJeDRxVW84RDlU?=
 =?utf-8?B?Q09rb2JoM3B1SEkwc1JSK3FjQnQ4OTBTOEFxMmxXVVhXZi84MG40c3FTRXdC?=
 =?utf-8?B?Q2k2NkJUdHduRFk5dFdzblVSZFdoSlhvb01tY2poMzJja2huTlpaZDdnMXhv?=
 =?utf-8?B?K2RvbHM3ajhrNzJ4RjBUeTBnTEtQVkxxK3IvN1BYOTFESmhqb0x4anZzL0Vx?=
 =?utf-8?B?ZDh2KzJUQTYxU2pNWWVvOS8xRGtjL0REN1E5UGZ4WHRIVk1wc2lVT1dtU1hF?=
 =?utf-8?B?OTV1MFkvb0xSN1JxQVZqNHhVYUpXSUYrNmlpVlJ3bVR3Q2JDT2hMcUQ1QVNu?=
 =?utf-8?B?OVY1YnBBZXBNVGxwTjAvWUE3cmdzMndCRzFBM1JGb3BuN2ZaZGtpK1cwb3RB?=
 =?utf-8?B?Z2UyV1FNSEtqZHZHUWVZeVRWRndVSngyQWUxa0swTE5UeXlON3pqSnJERVBC?=
 =?utf-8?B?eVRCYzJmZ3RCK01DM3dKd085bHZWU0oyUVVrSDdKL2txWlZVVVdiMUxxaVpC?=
 =?utf-8?B?dFdUTjBXdWRWZE1BeU9EeW5uUitkWUkrbFlvb2p4MThXMzYzVE84aUZlbVpx?=
 =?utf-8?B?N1kyZjlEcTdSOWxmM0JKMnNpMDdpQUhMdDNkY3BKaEZvaEhuMlZ2Rjdaekwz?=
 =?utf-8?B?U1JjQ3cwbFlJZFNqa2FGRG9rbjRIajVTL3dJQVE2TFZIdk5IZHlGTFJ3Tk1I?=
 =?utf-8?B?RHBYd3IyZDdiU3RiZTNQN2NCa2lnYTZUM0JHT2FrQWhTWTI5cVNlR2R5MU5a?=
 =?utf-8?B?ZFJVaVRXWEdNcXdpK2IwVWVuMlJ3SUdvdFFnNEt0TU5xNnBYMHVNYzBFd1Zm?=
 =?utf-8?B?SzR2RmFRN2w2cFZMVkV2M2Z2bTl1WFptdXlxTWdWME9TQVFQV2JxdU9TY0tW?=
 =?utf-8?B?U2FFTmNvMTVhS1V6ZFV0OE9pUVhNMWhoVVAxN2h2b1dPejdjekNOZGwrVFlq?=
 =?utf-8?B?My9WZS9sVGRIQjJOanplR0FQZkVRN3gxYnZrTGhWckdXUHZncjhjQjk3SE9n?=
 =?utf-8?B?Q2Q2SUl6QlZEVlFtbU5UYS8xa0FJeUJZdzBtbForQ3hOazdacDgzQXZ4eUsy?=
 =?utf-8?B?cXVjUm8xYmdTT2ZCUVpVcWZwbUdWcnFXQ2ZXbmRkQUZ1NHVMZFJudjUva0dp?=
 =?utf-8?B?Wmc5dWhKdVlNaTMvcEdzTnNqaERqd2RiWnBkd2JmdzlCN2kvbDlUK3hqdDNP?=
 =?utf-8?B?ZkRDNkI0NVF0SVlGWkw0TlFRbnB3a2EyWWVVNGY0VkNicFl1bHJPaUsxd1A5?=
 =?utf-8?B?VG9NdWRtNm5SdkwrZnE3UE9ORUZJTW43dkVVMXV5enhlL042VFUwMWxkK0tP?=
 =?utf-8?B?VEcvRzdpbThEUVB0SGFUc014TWVkeHpyZTRLbDhwQ08zQUtDVUMyNnoyWU8x?=
 =?utf-8?B?dTQwdVJDUHRBbFRhc1FXL2RCWjhUdWpyaUVBdHRwUTJybFkvcDdOQkhKVTJ4?=
 =?utf-8?B?RXNkK3NjYXFPOVNodlJEK0dmSWZGYkRlV24yWXBpdGRDcEN4dHhvcTRtb3Ry?=
 =?utf-8?B?bkdoL2ZRdUQ3Z0MrVW0zdjlyQVhFT0ZCS2t4QXpFQ1JUcjdJUnRVaDhkTHdn?=
 =?utf-8?B?dERvZ3Y5NnpBQXhFK1NMTkYzM2hoeWhUYnprSHo5aTFjWC93eUtvWjd0MzRW?=
 =?utf-8?B?aTBVYUFBMlg5UXRidktTN1FFSWlSZ2QvYzQrc3krRUxpVmhVK0JBTGtxZXdG?=
 =?utf-8?Q?e0rw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e3ed2e2-14cd-4677-be35-08db78e852d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2023 21:32:22.0058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mp+yivfXByYY2X/7n99lFTm/HO4r1mf1UXjTb+KwqTLXvLa/fJjF0902g9Hl191gJBhTwnQLjei4AJKBEgN3lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8567
Subject: [virtio-dev] RE: [PATCH v7 3/4] admin: Add group member legacy register access
 commands

DQoNCj4gRnJvbTogTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4NCj4gU2VudDog
VGh1cnNkYXksIEp1bmUgMjksIDIwMjMgMzo1MCBQTQ0KDQo+ID4gK1doZW4gY29tbWFuZCBjb21w
bGV0ZXMgc3VjY2Vzc2Z1bGx5LCBcZmllbGR7Y29tbWFuZF9zcGVjaWZpY19yZXN1bHR9DQo+ID4g
K3VzZXMgZm9sbG93aW5nIHN0cnVjdHVyZToNCj4gPiArDQo+ID4gK1xiZWdpbntsc3RsaXN0aW5n
fQ0KPiA+ICtzdHJ1Y3QgdmlydGlvX2FkbWluX2NtZF9sZWdhY3lfbm90aWZ5X3F1ZXJ5X2VudHJ5
IHsNCj4gPiArICAgICAgICB1OCByZWdpb25bOF07DQo+ID4gK307DQo+IA0KPiBUaGlzIGNvbmZ1
c2VzIG1vcmUgdGhhbiBpdCBjbGFyaWZpZXMuICBEbyB0aGlzOg0KPiANCkkgcmVuYW1lIHJlZ2lv
biB0byByZWdpb25fZGF0YSBhbmQgbGluayBmb3IgdGhlIHRyYW5zcG9ydC4NCk1vc3RseSBpbXBs
ZW1lbnRlciB3aWxsIGRpcmVjdGx5IGp1bXAgYWZ0ZXIgbGVhcm5pbmcgdGhpcyB0aGVvcnkgb2Yg
b3BlcmF0aW9uIHNvLCBpdCBzaG91bGQgYmUgb2sgdG8gbGlzdCBpbiBwY2kuDQoNCj4gc3RydWN0
IHZpcnRpb19hZG1pbl9jbWRfbGVnYWN5X25vdGlmeV9xdWVyeV9lbnRyeSB7DQo+IAl1bmlvbiB7
DQo+IAkJdmlydGlvX3BjaV9ub3RpZnlfcmVnaW9uIHJlZ2lvbjsNCj4gCX07DQo+IH07DQo+IA0K
WWVzLCBJIHRob3VnaHQgYWJvdXQgaXQsIGJ1dCBpdCB3YXMgcGNpIHRyYW5zcG9ydCBsaXN0aW5n
IHNvIGtlcHQgaXQgZ2VuZXJpYy4NCk1vcmUgYmVsb3cuDQoNCj4gDQo+ID4gKw0KPiA+ICtzdHJ1
Y3QgdmlydGlvX2FkbWluX2NtZF9sZWdhY3lfbm90aWZ5X3F1ZXJ5X3Jlc3VsdCB7DQo+ID4gKwlz
dHJ1Y3QgdmlydGlvX3ZpcnRpb19hZG1pbl9jbWRfbGVnYWN5X25vdGlmeV9xdWVyeV9lbnRyeSBl
bnRyaWVzW107DQo+ID4gK307IFxlbmR7bHN0bGlzdGluZ30NCj4gPiArDQo+ID4gK1RoZSBkcml2
ZXIgc2hvdWxkIHBpY2sgdGhlIHN1aXRhYmxlIGVudHJ5IHdoZW4gbXVsdGlwbGUgZW50cmllcyBh
cmUNCj4gPiArc3VwcGxpZWQgYnkgdGhlIGRldmljZS4NCj4gPiArDQo+ID4gK1JlZmVyIHRvIHRo
ZSBzcGVjaWZpYyB0cmFuc3BvcnQgc2VjdGlvbiBmb3IgdGhlIGRlZmluaXRpb24gb2YgdGhlDQo+
ID4gK1xmaWVsZHtyZWdpb259Lg0KPiANCj4gV2hlcmU/IEhvdyBkb2VzIHVzZXIga25vdyB3aGVy
ZSB0byBsb29rPyAgQWRkIGEgbGluay4NCj4NCldpbGwgYWRkIHRoZSBsaW5rLg0KIA0KPiANCj4g
T3IgcHJlZmVyYWJseSBJIHdvdWxkIGp1c3QgaW5jbHVkZSB0aGF0IHRleCByaWdodCBoZXJlIHRv
IGF2b2lkIHRoZSBuZWVkIHRvIGp1bXANCj4gYmFjayBhbmQgZm9ydGguDQo+IA0KV2UgaGF2ZSB2
cSBub3RpZnkgY29uZmlnIGRhdGEgYXMgZ2VuZXJpYyBhbmQgdHJhbnNwb3J0IHNwZWNpZmljIGxp
c3RpbmcsDQpTbyB3aWxsIGltcHJvdmUgdGhpcyBwYXJ0IG9mIHRleHQgd2l0aCBsaW5rLg0K

