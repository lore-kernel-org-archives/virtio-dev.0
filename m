Return-Path: <virtio-dev-return-12965-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2627FEB64D9
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 16:29:52 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 62E37E694C
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 16:29:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5034B986429
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 16:29:51 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 435DA9863A6; Mon, 19 Jun 2023 16:29:51 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 30E0A9863A9;
	Mon, 19 Jun 2023 16:29:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AFYiS6ig8wC90s9G9p7lppaSKgCHYUN0XOaFTxs/ZO+QmUZcZ+NA/WGJVVc4ISUYL92pjk9tUnE/W65sdTwctHg5KKMt9DOVb5uCNd5ysaJoQWFaHF0fhic5DnLf76xIOAwVBOT13E3PMLX58VTn06DSxegNW1Hc7czN37b41BqlSGZ/muN8pPK7b5Nvr4E7/GMfTnUuqwJo9BKNtkoZbTAl39WQAkYf0uuFXkp4SkK14rawfvcNcsAj2d8IJdUX2LBNCKHR/fDHPTg4f2W1bV6cSUvEBpE8SUiUXO8JCo2EgHTg05kpB1/7N6P/S7/zdRqIEUrIRrb4bubaABFzfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1rk9n4K5uciGGsx4MW3C1+pc9UxOqrEPPE6TNo5MdZA=;
 b=Otk4PhtISxByLaAU9FKuzuq5HxWGiuNa88EHi0B6uQPeNM8wtHMEpzW/slok9GXUXFNrpl8vwqCYZt8SqI+0wJMZCIZrMLrJLFkC6tuJpCYkU97e714GARWvakTcP3W58Ugmbxq8MsFfq+ID/s+Z45+pxXhQ1pEgkTPodQNdVbM8PmyfyH0l3hCj4M4wb/pEOctOUxk9fp9872P2kLn0klULyrkmYKghye4iJOb+Mc+pVdBCfiv6VWwfjVelr1tlHEojGCFfc7MKvZCHl8waVnC/40N7KorR2VdKqy5VFGpr578kp/Nd/SkAG4i/jbaYLTsF/wFj2edn0oCE4JoxGg==
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
Thread-Topic: [PATCH v6 3/4] admin: Add group member legacy register access
 commands
Thread-Index: AQHZnhzNwhtFR5mF+Uage7sFrLqCZ6+SV8kAgAABfNA=
Date: Mon, 19 Jun 2023 16:29:43 +0000
Message-ID:
 <PH0PR12MB5481EE01C25B4C170E498177DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230613173015.1244486-1-parav@nvidia.com>
 <20230613173015.1244486-4-parav@nvidia.com>
 <20230619121724-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230619121724-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH0PR12MB8775:EE_
x-ms-office365-filtering-correlation-id: 3c6ae4b9-ac21-4213-6734-08db70e26362
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 71x25CRdpIp+KZSR6iM9iL6BZfUb06HpnxzktHLRxDP4p+V424Memd8n+5luAfKHUDZjnSXc9OehUoEik3tg/dBiqMmhdDTCf1Jam1bgXiq+Nw1w439YuiEjBmgB7/wh0UJYMx+/fdJ9+6bqgWaY+K2RSxXbcG07FdnaxQEasGgbG2SANFDtPuWupUZVEzhTsP1a+FmU3/AUKJr4mqVxwkNa+ggS2X7GjrVa9wbEsmS4lfSEywAQdwyb6jDRmwe/gmRJQhy3xg/JS6hkRxjOzAtCau5ZMX+21qqe6FEikFsF9l2djLbTTKJMu9fNEMlrkIFD4yvThQyLuCcnX67LiGyfOdNZwHPCc8Moy35zjYkCPP6JqhEOfzb1k8DI9ro2N8M/bbmbnU9qol9sgvmmIme+olx7d4pxWEpJVTjAIVdSor/mlzK5V00jhSoAppJ0oze8+0k8dN9JReMLelYrrivztWsz7zFk2niI3D00n642oHQG6D6DvNYpogIThXQ2Pg6R4v0DHEzq7FVR3eQsGZ8hf8gkrRtIh0RLsM/IxWyIfXov6rAKuaAkoYr/O0kFCK4IVhwm3hVtpNUHHKuMCNlGjOdzkc2jjnys3/zGYQtSk/iCf+BhjLqjLpsbYLld
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(451199021)(41300700001)(5660300002)(52536014)(8936002)(8676002)(2906002)(38070700005)(33656002)(55016003)(86362001)(9686003)(107886003)(26005)(6506007)(54906003)(186003)(478600001)(7696005)(71200400001)(122000001)(76116006)(66946007)(66556008)(66446008)(64756008)(6916009)(66476007)(4326008)(38100700002)(316002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MjZwRE1pWXNHeENLQm1EWWhXOE9NNGQ2ZVhqdmYzZ3dBbzV5cUhjMjFXRHZl?=
 =?utf-8?B?QXpwUGczdGVOdi9ZNElqNVNtS3hUMm85OFdkRzg1bHlGc1NDcm9yT05XSXVE?=
 =?utf-8?B?T2hLbnRzWHZDaW9OeXRMa2FpY3dmdHNCSUErRXQ4YkE5WDZCM2ZucEpFOVUw?=
 =?utf-8?B?UjhEak9xWHFRZkZoRngza0tDQ3VEeFQvRUd1UWdYVnhrcGY2c0ppQnRIbEJC?=
 =?utf-8?B?RC8vWDVPZ2Q2aVVRU29peUtuaWZsd2s0c0liWnJVVEVJR3BQTWV0VXZBYWxs?=
 =?utf-8?B?QThUZVE3clRjVWdMZmdsMDRuMzBodFdwR29KOFhxN240MkFKd2p6dWpqVk44?=
 =?utf-8?B?cUZnRVdtYktzNzNTWGNtL0RiZkZraUtOck9kWWJySzMweUxXcVBKS3pKK0h0?=
 =?utf-8?B?T0dscXdHZ3RmQXgyYnc0ZHc0YjFtK0lGRGY0UWVnK1RQdFk4YVluZ2cxTXp3?=
 =?utf-8?B?Q1h6aG1iTURvVnFKQ2RkVWZjbUg2S0UxN1pRWHRxd2ZMM1VEUEZCR2tkTnVt?=
 =?utf-8?B?TjdsY0Q0NjRZa05vQkt5eTJDN1lGL2tHbmlCK0RDQkpNK3JSc0JDUnJJd05l?=
 =?utf-8?B?VHJka2NIYmQwNVhIbnFnNlRKYUZOTlNiYjVYVU9nZzZPSlVjdDhMeUQyNVVM?=
 =?utf-8?B?SXg4MlRTaE1HcE9zaVRFL2k3KzhIZTdKMzVpcjAxZU40TkZoTWpKMEkycDk1?=
 =?utf-8?B?ZzB0L2VKNEMzOEJRVnpiZURTRVFEUHA3NmJpaVFLR1N3TUVhSm5vamV3dVVR?=
 =?utf-8?B?QUlCYUxDWGtCQ0VrNGQ3UFJUeEw5RGRYWDM5UUlUL2YxTnZMYUNDQ1h3aWRa?=
 =?utf-8?B?MDZlTlVhTEpFMVplUFRiUUtHMlZQUnR5eC96bWFTYmNtL3hDbUgvS3RJZG5N?=
 =?utf-8?B?RUF2RHc3QlZsc3dnUlFnellTbUk2dmQxcmIwbEVpdW1EM05YUGJlc3ZvWXl1?=
 =?utf-8?B?S0s0SERpZ2IvcEJsVUUwNVRLUWxBL3JxeFZaSi9SR2ZrN3VJRklsSHIyekVP?=
 =?utf-8?B?WEpFQ2pZMkVjTTVVc3IyQy9JR1ZTZzlHVE1JNXBZaFZtZHg3VVp3cWk0eldy?=
 =?utf-8?B?TlhLV1hOYVp2SjE5ZDRsTlNaM2swS3RXN1RFRkF4djRBRHdTbDdEM0FhMkVm?=
 =?utf-8?B?QVdXdkdpamNQOEF2V2RrT2J6U0VoQUtZTnBIRktSa1Ftdmo3M2daM3I5T3h6?=
 =?utf-8?B?ajZCYnREQ0dDMHNTWW1EV3lZV1lybGZxclAyNFNHWmxIeDVZU2tKcFVFT1Yy?=
 =?utf-8?B?dHFvbkxIbXB0blJ5YklmZEFKUWR6dXRqQXVoUWFYNmlDS1ZNVjJYV0w2aS91?=
 =?utf-8?B?NnZkK2pQcVZjcmVTL1VZRTIyTS9WbzV6UjBZVGplV2gzZFlzNHRwdlUrYVFn?=
 =?utf-8?B?cGY0UnhXeWl5ZlRHMWxaN01DVjlRVGRqMmRCK2JVRUNkVks2a251WHlDOHh1?=
 =?utf-8?B?a0hqVmd3aTk0SityNVIzb0dQSkcyOWc0c2I5c2lONUdyVFk3V04xeGRzZFlx?=
 =?utf-8?B?bUdBMVRVU0Q0d0JrWlJCRm9QZmNPc01CSmY5YmpINVljaUQwamxXQlk1ZG80?=
 =?utf-8?B?M0JuU1RkR0xjYUdNMG8vS01wcHRZc2JqWjhwYnlPNEFpTnp3c2d1cVljbGlS?=
 =?utf-8?B?d2xtd28ySkNqM1dIeUdVOW1yRldsK2JwK25xdWZxbXNCU0FXNXlXU1lsdng3?=
 =?utf-8?B?N2ZsK2d6ZjU2NnZWbHZDdUlBZ29vWkU1WVd3bUlBZ3NUNTFGOTBQTXdrdlJF?=
 =?utf-8?B?YWNHRFh6am1Odnp0REVUeEJLMm40QnlKMld0V1l0bW1LNGNIblMyZ3RSVGxZ?=
 =?utf-8?B?Q1g4Y3pFbVdnL3Rjc3U5eU1PZnpMeHI1NDdPL2lHWkhpWWFXMzVXWDFzVi9G?=
 =?utf-8?B?SmNzeDBjcGF4RU1QTHdmbzdDd0wyYkNJQmRTSEUvWXRYUllmdkEwLzBnZ3JN?=
 =?utf-8?B?ZndjSGs3eG9FVWxqZXppRStwVDFCR05XcXo3d2xhSUJBK3EvTDdTVDBreUo0?=
 =?utf-8?B?TmtuRlRPdkNrQ1R6djFYRGIzZnFQa1lXWnVZdkRGNnRYOVdXdFpCOVRnaWpD?=
 =?utf-8?B?cTUxdGt4T0JXb1EyOWUrMmg5aElRd1g0Y3hyZHRhNU0vZnE0Zjd2N1ZoNWJs?=
 =?utf-8?Q?59TE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c6ae4b9-ac21-4213-6734-08db70e26362
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2023 16:29:43.4929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: huzsKefJP8Oo80dYNW9uly91LEuwBF5xL0rIt/xUm79+KsF90g42wIR/lPBZPKMR07cDzRzh3RydaHlay4nVrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8775
Subject: [virtio-dev] RE: [PATCH v6 3/4] admin: Add group member legacy register access
 commands

DQoNCj4gRnJvbTogTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4NCj4gU2VudDog
TW9uZGF5LCBKdW5lIDE5LCAyMDIzIDEyOjIxIFBNDQoNCj4gPiBkaWZmIC0tZ2l0IGEvYWRtaW4t
Y21kcy1sZWdhY3ktYWNjZXNzLnRleA0KPiA+IGIvYWRtaW4tY21kcy1sZWdhY3ktYWNjZXNzLnRl
eCBuZXcgZmlsZSBtb2RlIDEwMDY0NCBpbmRleA0KPiA+IDAwMDAwMDAuLjg5YTRmNDkNCj4gPiAt
LS0gL2Rldi9udWxsDQo+ID4gKysrIGIvYWRtaW4tY21kcy1sZWdhY3ktYWNjZXNzLnRleA0KPiA+
IEBAIC0wLDAgKzEsMTM4IEBADQo+ID4gK1xzdWJzdWJzZWN0aW9ue0xlZ2FjeSBJbnRlcmZhY2Vz
OiBsZWdhY3kgY29uZmlndXJhdGlvbiBhY2Nlc3MNCj4gPiArY29tbWFuZHN9XGxhYmVse3NlYzpC
YXNpYyBGYWNpbGl0aWVzIG9mIGEgVmlydGlvIERldmljZSAvIERldmljZQ0KPiA+ICtncm91cHMg
LyBHcm91cCBhZG1pbmlzdHJhdGlvbiBjb21tYW5kcyAvIExlZ2FjeSBJbnRlcmZhY2VzOiBsZWdh
Y3kNCj4gPiArY29uZmlndXJhdGlvbiBhY2Nlc3MgY29tbWFuZHN9DQo+IA0KPiBJIHRoaW5rIHRo
aXMgaXMgd2hlcmUgYWxsIHRoZSB0aGVvcnkgb2Ygb3BlcmF0aW9uIHRleHQgc2hvdWxkIGdvLg0K
Pg0KVGhpcyBpcyB3aGVyZSBtb3N0IG9mIHRoZSB0aGVvcnkgb2Ygb3BlcmF0aW9uIGlzIGRvY3Vt
ZW50ZWQgd2hpY2ggaXMgYWdub3N0aWMgb2YgdGhlIHRyYW5zcG9ydC4NClBDSSBzcGVjaWZpYyB0
aGluZ3MgYXJlIGxlZnQgaW4gcGNpIHRyYW5zcG9ydCBzZWN0aW9uLg0KIA0KPiA+ICsNCj4gPiAr
VGhlIGdyb3VwIG93bmVyIGRldmljZSBjYW4gb3B0aW9uYWxseSBlbmFibGUgdGhlIGRyaXZlciB0
byBhY2Nlc3MgaXRzDQo+ID4gK21lbWJlciBkZXZpY2VzIGxlZ2FjeSBjb21tb24gY29uZmlndXJh
dGlvbiBhbmQgZGV2aWNlIGNvbmZpZ3VyYXRpb24NCj4gPiArcmVnaW9uDQo+IA0KPiB3ZSBjYW4g
anVzdCBzYXkgInRoZSBsZWdhY3kgaW50ZXJmYWNlIG9mIG1lbWJlciBkZXZpY2VzIg0KPiANCldo
YXQgaXMgdGhlIGhhcm0gaW4gdGVsbGluZyBleHBsaWNpdGx5IHdoYXQgaXMgY3VycmVudGx5IHN1
cHBvcnRlZCwgc3BlY2lhbGx5IHdoZW4gaXQgdGhlb3J5IG9mIG9wZXJhdGlvbiBkZXNjcmlwdGlv
biBzZWN0aW9uLg0KDQo+ID4gdXNpbmcgZm9sbG93aW5nIGxpc3RlZA0KPiANCj4gdXNpbmcgdGhl
IGZvbGxvd2luZw0KPiANCj4gPiArYWRtaW5pc3RyYXRpdmUgY29tbWFuZHM6DQo+IA0KPiBhZG1p
bmlzdHJhdGlvbiBub3QgYWRtaW5pc3RyYXRpdmUNCj4gDQpBY2suDQo=

