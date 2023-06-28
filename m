Return-Path: <virtio-dev-return-13115-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E64CDEB64DA
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 04:23:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5030F2ACA1
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 04:23:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3928C98667F
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 04:23:17 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2E07D98654E; Wed, 28 Jun 2023 04:23:17 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1869898654C;
	Wed, 28 Jun 2023 04:23:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IDXOWZA4dT5IJOue7DaIf82mqJsQQiU6U9H/MDOw0MDJaordhHbnU0c79hSn8ofVrRXeeBqmCbohA/jfAPoTk/PjJx/dBh/Vt1QIRL2csJRyl1LdxbodtfgHBwTqt933zenjvnS8xF24pkANDHRbQ9hfvjyBr92+4rZeB1Sw7y5sFhdDyUjcQzKB3fsa4Mg01Y+5A5WhWumgqrJLO48WfhDpnZjSFVl1/LydA/yV/i3DIx9vN7BUKEDeYak9clk0zdeiUpzqh/V5G2wusgcoCy5Lmyw9Bi2sJ2rjSmuhxrnVz3M/BpF2OssCCaN7sZ2XkmNrMlh3kKMegm4QCNo06w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=goxz6EKuRUCkL5mjAIw3mWpZbqsnWZHSdm0hZ5KtQXo=;
 b=BrR2++cU+vavurd0kzIu9fi0v1hkUquAezvkK7mGDTwDl2F88wkP/y4TgSkYuzUMi5nYKjWJS3QFs0RJLx1jWc50b4ktMS6SVGg/Gt2F5FIMswNB22shpyYAXKqo247nLepostO0vZU39NcC+jYqX4OMdDjBtTbw+4AFeCzqjxwWpRPOdMaH6e5LLPTWSl0X4SDd586juBv2E4WSNlgPabJwsqee7p5peSuRC2xhLRzP/aJrkd8jAFzluHqdBBHuMlpUXA1GIiV8BoyCLFu4Pf+FHCK9KM4dXRSqmilaEfPEfVoM3NCSEVkRWdouZ60mLU6yY6U9PHpSPr1GUoFBLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>, Heng Qi <hengqi@linux.alibaba.com>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "Michael S . Tsirkin" <mst@redhat.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>
Thread-Topic: [PATCH v19] virtio-net: support inner header hash
Thread-Index: AQHZqRVyfixvgxNlsUC5ASNdYCAGYa+flAoAgAAIhiA=
Date: Wed, 28 Jun 2023 04:23:09 +0000
Message-ID:
 <PH0PR12MB54811123CFCDEFE3B48D4381DC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230627163549.40028-1-hengqi@linux.alibaba.com>
 <CACGkMEvFmAiWDp8w=ytin21Oi+PcTb1X3Eve7Kt2NVr_RkhgmA@mail.gmail.com>
In-Reply-To:
 <CACGkMEvFmAiWDp8w=ytin21Oi+PcTb1X3Eve7Kt2NVr_RkhgmA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SA0PR12MB4413:EE_
x-ms-office365-filtering-correlation-id: 1177f5a5-ebf9-468d-7136-08db778f60fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 M/+3NcLA1+Gs0FAGYJTW/nzA6uyiqw1UrOkCFEI0jSmBYKPv0CLCKWbPqATlTTzFgAvFsIFOLvZKX+ib4CMnN6/zXeJgcdQkrwYRetptFC7iaEtOC2BN0keCJEqy6/ZMUy6SWRZmA0KwjIeAJ4Ok9VjbemNBWbiYO7FiyAZe+DnLCgx8zSPK+peB9L23EOTrjclnPzyFxoepgjJe0uPRzrZN+mvXYFDJyY7VLta9QqIVEATJPmmgW6X7xtjtYe66MpMim6Yfc3Mreev5eoWvS91OuxNn8l0QRz+T22GOXjHwehqdDEmvujeV+Mwu77PpxBPyUrRIg3M3m+6bGR04u/hHNql6F1H9iIFRyI2RI/qoJmt0RFkKUW5mLX2K68ArEPxq0wfT/suTYNnBYMQA+Dy0kOx84iSRlltrVcaqfa0q2Nz6awpG7HMDf6OuRuBxke1ovempjoIw4ucFIiEjUj2NAsAvHL8gNMJkcoJjvSJXOnWOce/tqwRL4FV9YZGdAHpqlnaOTzYJ/3US1LLkL/0H7KMr1ZUDKtd72W9+yE0bK4Vy3B6MfDQBM9QpVMLpCkjHU2xvkwFXpn9nrB0a3DsxWniN6RuN8TrvqiFHL6KhtuoPHNrVAejye8BNqIwZ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(396003)(366004)(451199021)(54906003)(110136005)(478600001)(7696005)(83380400001)(55016003)(38070700005)(86362001)(66446008)(66476007)(64756008)(6506007)(71200400001)(66556008)(9686003)(33656002)(4744005)(26005)(186003)(2906002)(66946007)(4326008)(122000001)(8936002)(38100700002)(41300700001)(76116006)(316002)(52536014)(8676002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aWF2SjlIKzFmd0xmazROc21oTHdwN0JtVmt6cVpHK0Q4aTV0ejh6MVF5NTBx?=
 =?utf-8?B?ZGFjME8zeVVCWWpvSVFhVE5qVkZPTnRPUGJWdkFLUHBkenpwUzcxNG5OQ0Iv?=
 =?utf-8?B?cVk3clZXeTdqbFhaSGVZVVNEc2EwZkdxckg5V0o2bTF3ck5vQlczOXJjbnJt?=
 =?utf-8?B?b29udVNPTThURHo3ZlVBajJucm9aek55aFNSajFOeWU2cnQxTU1zOENLbTFB?=
 =?utf-8?B?RXdqOXdVVkUxNUsxUU9mS1pJQ0ZlOHI5RGl4Q2E3YTJFM1p0TTlhVkVIUGVa?=
 =?utf-8?B?VVoyY0drWi9QY1F5Q0pTY3VoZFFzaHdiekxKd2dVQlZzUWtvZ010V3k5eFkw?=
 =?utf-8?B?R0RrTkdLTFNmNTViZ1VnUlh1UmlYVW50NFF6MjR6WENHS3BQYnB1NGdBc0Vu?=
 =?utf-8?B?MGF3WXp2QWF1aTZLcnhMalNDK0NqbWYxZzBXdDRKQUtTNnp5QnowYkpsYWdu?=
 =?utf-8?B?dkVHV2FkSnlhK1ViYWcraFB6czFzYXJkamZjdUxoZzc3UHRGWGNiamRsRDFF?=
 =?utf-8?B?NlJIMDd3ODkwZE0reW9YMFFyYWFkRVk5ZjcybncwMHNSOWZMWnZaeEI3WWJE?=
 =?utf-8?B?WWt5SjBrY0o5T3RtMk0xTkphUEt6YnhtTHQ4Uy9PYndtcHhrWFBRTjdqTWp4?=
 =?utf-8?B?blYyeGJTSURaQUxEU0JjY0ZnREtKZmVERkdQOGw3NkxXT21zaHJ2SXpvaXRM?=
 =?utf-8?B?cEtkMDA2ZjFHb1VuTm5MZ3RNS2w4cGZweHJpZ3NOcDdTaHA3Z0V0TEwxWFF3?=
 =?utf-8?B?bFFFSXlkTUVRcHNjL3JPQWtrQkZ0WGJxQmpDRVlGNDUwZExZeFRmRkpxRHFr?=
 =?utf-8?B?SzU1VHhBREpkWXJKMWtMaWxzR28wbUpxb3lxeCtpcDlJdkRxZTk5MWJFcXJ5?=
 =?utf-8?B?TzdvRVNOZlRmaVBCV213RWhmRGo4Uy94TVh2djFNelBpRUFRSWc4NXc0MkFt?=
 =?utf-8?B?SzJ4RER5NzcrTmRuWEVLemJRbnFheDV3cEJINElPM0pVaUJJMUp1eHRoT1Fy?=
 =?utf-8?B?VXBSL1p0VjZidFBtRGNZYVI3c2RRaWJ6ZEVYWVRyUHB2SXRCa2ZuS3RkSHEz?=
 =?utf-8?B?c29IQWp4dmpKeU5qU0dqR0RmZVBIU1F0L1B5c2Mxa1d5VzF0ZDF6bm1lYXM4?=
 =?utf-8?B?OUM4d2hzUDVGZGRiY3JwT0wyUzVWOWpMVDVBMC9CQmRZayt1US81RGhKMW56?=
 =?utf-8?B?a3F6T2hvbUdqWHhieUhncDlDU0tEcnFoZ2FBQUR0SUpvbWJ0ZGNHKzcrWm9k?=
 =?utf-8?B?TSs0eGxLc2REYjN5T0lSdTVqMjRsUWl2a0ViTGdXb0ZKeUNlZEZlWnh6NktI?=
 =?utf-8?B?MjQyN215eEhHeitlaVdTVEpxNmNNVXF4Z1JWcDdEalRWVDZOeG9CTHVKQXF6?=
 =?utf-8?B?WXVUSUF3d0gyeW9jYU9Pc1Z0ZGV3STVqWUhGa1RRRFZFRnVyQ1c5UlJpUDJs?=
 =?utf-8?B?SlcrOExlNUc0dUkxYjRPYTlCL2cyQjB1UitLVVZac2FWTHNVaVJVT3ZiekNv?=
 =?utf-8?B?bHZIWTVXMjdBRS9jU3NaQmh5elRSWW8zMmRnR2pBei83QzJ4QXJvNkZadWhX?=
 =?utf-8?B?NnJDaGthbDFISnZMRUpaNEJQaG42eVpYcnoveUg0aFlnTHZCUU0zdUx5dTR4?=
 =?utf-8?B?Q05yK0lJYVlBQWxMMEVqclFWeHFpSW1ZL3M4NHgvOHh2NTNtejRvWEw0K1BN?=
 =?utf-8?B?MkJ5OVhwUDZuSUs0VXNRNERWeXpzSHNteWRXanVWRnlUUkdkSTFMdXY0aFBU?=
 =?utf-8?B?OW5XUUpDWERjME1WRUVZMXFkWlB4eXU2cmw2dExQdS9XSUxWYjdZbllXTWVM?=
 =?utf-8?B?RW83RURXd0JyTnZHbGFTdThOa1JCZG4rQVBxK0RjNjR6MkxLaTIxbUhpM0Zu?=
 =?utf-8?B?L21sY01XelF6ZG11VmhnVm5CNTBJNXUyMkJxWmFMSGt5dHA5OWdYSHBna0lo?=
 =?utf-8?B?Qm9tRWU4UWVQaXZ2NlUvd0hrbWwrdzFYT3d6Wm9MNXVEWVZaRnVjOEJFbmVk?=
 =?utf-8?B?ME9pVXJHVkg1U3JjMmpWcm5iM1J1SjdSK2ZnNGNrSXBsZ2dvY2t5Sks0a2pq?=
 =?utf-8?B?NUVvNGtZYnM5ZGtQUGxKNEdNL1FpbHpyVEErUzYyd2poK2tzcmxld29YeXMr?=
 =?utf-8?Q?CewQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1177f5a5-ebf9-468d-7136-08db778f60fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2023 04:23:09.3998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J07MpdpdvqsWSjwdzQ3vGInJMPDu+dqO1aiCxal0ZIJw5xPUz7/SlJgyWDSIQRNxkJyao/7Djc48ZxGG0EQSvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4413
Subject: [virtio-dev] RE: [PATCH v19] virtio-net: support inner header hash

DQo+IEZyb206IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFR1ZXNk
YXksIEp1bmUgMjcsIDIwMjMgMTE6NDYgUE0NCj4gDQo+IEhhdmluZyBpdCBpbiB0aGUgY29uZmln
IHNwYWNlLCB0aGVuIGEgdHlwZSBhZ25vc3RpYyBwcm92aXNpb25pbmcgdGhyb3VnaCBjb25maWcN
Cj4gc3BhY2UgKyBmZWF0dXJlIGJpdHMganVzdCB3b3JrcyBmaW5lLg0KPg0KUHJvdmlzaW9uaW5n
IGlzIGZhciBzaW1wbGVyIHRoaW5nIHRvIGRvIGluIGRldmljZSBzcGVjaWZpYyB3YXkgdGhhbiBh
c2tpbmcgZGV2aWNlIHRvIHN0b3JlIHRoaXMgdmFsdWUgaW4gb25jaGlwIGFyZWEgd2hpY2ggaXMg
cmFyZWx5IGFjY2Vzc2VkLg0KVGhlcmUgYXJlIG1hbnkgZmllbGRzIG9mIG1hbnkgZmVhdHVyZXMg
Zm9yIDEuNCBhcmUgZGlzY3Vzc2VkIGluY2x1ZGluZyB0aGlzIG9uZS4gQWxsIG9mIHRoZXNlIGNh
cGFiaWxpdGllcyBqdXN0IGNhbm5vdCBiZSBzdG9yZWQgaW4gY29uZmlnIHNwYWNlLg0KIA0KPiBJ
ZiB3ZSBtb3ZlIGl0IG9ubHkgdmlhIGN2cSwgd2UgbmVlZCBkZXZpY2Ugc3BlY2lmaWMgcHJvdmlz
aW9uaW5nIGludGVyZmFjZS4NCg==

