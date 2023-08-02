Return-Path: <virtio-dev-return-13428-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 652BDC04A94
	for <virtio-dev@archiver.kernel.org>; Wed,  2 Aug 2023 04:50:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 91FC0F3F65
	for <virtio-dev@archiver.kernel.org>; Wed,  2 Aug 2023 04:50:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DC66B9868AD
	for <virtio-dev@archiver.kernel.org>; Wed,  2 Aug 2023 04:50:33 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 42E8A9865F1; Wed,  2 Aug 2023 04:50:33 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DB1F99865EC;
	Wed,  2 Aug 2023 04:49:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QwIuolFEJXaJidWtpb8JoyG2Asu2m0yw9s1oKOP3Z8GTrWXtfqlUD0Et72+QoFyS1FBNqQ5RCQ+U3jcTgHT/gmGgtZgASWUdQMMNw3O5+CyZT06TKPvuJU6/36eBKntNXH4MiIRSnvXJ3gky9kdlVkYqZTvQ2u9ZDpN7XnRvK7SI1wpf3V4M8dWS9hrt6cvILcEDQIxQpW2Jr9Rj+asa/6eQj4wmUCho7VO+VlchiXl0DHd0bqmdTmY62O5zTE/bWvJ2WdmdlmSVivUPgqB1d97NDq3155LW54Ad2xAFLEMlAvjSnez8B8K3smIQ2G3Oga0JAWNOqtL7D+kcuTL8Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pjSokwrl8J/ou1o7nta3J/ojKzs21Udl1fVMHqnv8uM=;
 b=Qzq44jdPjOftj/qGHyoDF9CjrecT/nDK4iqax3pglNiQCcq16YOEoBnBR98ianfMHzrJMnDq9pB4LHcOdx6/6DWp//+aa2Jizffe1xJb5H7ejbJTEisuKn5IuRx1z/qUO5GxP1OmAocPy9ceo/RwUmXFr9/yYlpe8m6vfhChlRsVT/5BKJwoTVNNC72KhVcKe+b+dXisAg4gJgWgXL9WcSvcWdLTj0dWSlF4eeyGNehoEz9a9ACuXMdqAcqjGRfu9jBW/2juQ8/8GGkfv3cYXxM8tNp6leqvggNyQLaDX/AsQAlIbNuyTYWX1qmsMlJu/chp8y4zPQ9bVvG0y+wvhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Chen, Jiqian" <Jiqian.Chen@amd.com>, Gerd Hoffmann <kraxel@redhat.com>,
	=?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, Robert
 Beckett <bob.beckett@collabora.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>
CC: Stefano Stabellini <sstabellini@kernel.org>,
	=?utf-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?= <roger.pau@citrix.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
	<Christian.Koenig@amd.com>, "Hildebrand, Stewart"
	<Stewart.Hildebrand@amd.com>, Xenia Ragiadakou <burzalodowa@gmail.com>,
	"Huang, Honglei1" <Honglei1.Huang@amd.com>, "Zhang, Julia"
	<Julia.Zhang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>
Thread-Topic: [VIRTIO GPU PATCH v3 0/1] Add new feature flag
 VIRTIO_GPU_F_FREEZE_S3
Thread-Index: AQHZxPBmx6oJ9gLSW0KyczkfJaHsia/WbxOw
Date: Wed, 2 Aug 2023 04:49:26 +0000
Message-ID:
 <PH0PR12MB5481C2248C74E551B3318DD8DC0BA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230720121844.8956-1-Jiqian.Chen@amd.com>
 <BL1PR12MB5849C19607B02CDA76BD9F61E70BA@BL1PR12MB5849.namprd12.prod.outlook.com>
In-Reply-To:
 <BL1PR12MB5849C19607B02CDA76BD9F61E70BA@BL1PR12MB5849.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DS7PR12MB8275:EE_
x-ms-office365-filtering-correlation-id: e5880819-1706-4bd1-cd99-08db9313d9b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 pxJm5Wl3TqHOn2NmfjsSYrC8bNjOaCSuMLnS11miKvc+TYKd/2VEck1MYsnjui9XQQ4M7hKx0ToOfp6+m+0x/WJcPPYb5MfDG7hWN+ztYkF8SHsjr1vx33UNMNGe3PmEy2G4knZ+GU2wxSjLaJR6znzV5qiTGVZjdP+RwDvqZHd5hsb0IONJEEqSeFOwZ1+k6u+ygn/v6t+ayc8rgDgOKgb3EztPWTM6UgSfjrglgsWn+WTv7L/2UblhZx583+eOthpNdzj6/Q0TyK/Rs0/qeIeT0xQRFtLadnbf91b1KQD35TwRvaNBe8KCASVFJtheyroD8Iih56JcR4MVG0RaQbGh1WHTVOFkSidWWzHswdI79QI2IIHs+W+yokrDoEj33OTAdz8vViibko8f19cYAwZO0gRM88slkqFJuh7wVI7c7nyX6F28xGWcvJZC3qkVgTGEARZ8vBB14eMogSwIuqMJfNqb6cSLqQ2zd84eWd6Mn1+wK5sH+OJCcsX29ZXSuf7YyMq+3NpRz04oPh3Mmop1ZWTwtzVImI/p9YRWZH4JzNKhVqu3oTvLvvR4LszgNnxRpmL2uWxYDgEfyl9RyboZJE43yjeQOS4VjUm2uD6q3i5X71rDR41Doe1Lfey14arldPOHdFzvWuTRXw8baayP3uKJ5KtXm+T8gCmhZTHtBTHq5lAuDSl8dswVVvi/5C3XnKgRiKGSGmIxkhUQfg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(451199021)(7416002)(8676002)(5660300002)(83380400001)(122000001)(41300700001)(38100700002)(316002)(186003)(8936002)(53546011)(6506007)(38070700005)(4326008)(52536014)(66446008)(66946007)(86362001)(64756008)(66556008)(66476007)(76116006)(9686003)(966005)(2906002)(7696005)(71200400001)(33656002)(478600001)(54906003)(110136005)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OFZ2WW1XU0grL2VvUmpQM2FRemJVTWRGRDF6NFpkZ001aVFkdXlVSVZ2VFZ1?=
 =?utf-8?B?dE1lUVlqMi9tYUJpSlFQSDNBTGtyZXlGMVRTNS9MV0V4KzBkZ3RlTzdEOHdq?=
 =?utf-8?B?K01ZajZWZ2g5MWpXME0zQTJoamxGcnpJWDBSK0J6Y1pQaG9UeFJHSGZqNld5?=
 =?utf-8?B?dVBieVRlcE9POTMxSnFkb1JqY3lDaXlnQmJVamM1NkQzaDNJdzU5UFV6Tkc4?=
 =?utf-8?B?d3RsWEtKS2RoSyswUU9SVk1ONlZSbG9ZZmM5d1RTbGlTZGlRUVpsRDB6bDk0?=
 =?utf-8?B?SmlBMWExRnZZaFlWTlF0ZmpqMjA1WnZ4cHRPOUZzVFN3Rm92Wng4RURxWkpJ?=
 =?utf-8?B?aU5pNWwyaXBPeFV1c1RKcTZpTnVjVHNnK2pJdHFvcy9FVHhRM24vc1p6dWQ5?=
 =?utf-8?B?MHFYRUkrUk9IQmt0TWQ4TjFUUFphM29FdWpoQnlwRUFXN2Z3NWgzTll0Z0xL?=
 =?utf-8?B?NkJ0WnBjTFNYVUNRZ2hyL0lCa3NvYW1HMDBGaE1GdTFkaU5XbmFvTFJmWnZR?=
 =?utf-8?B?RDFOckxmbGN6SXA4d1hWcmRWQm1ZVm1rSnJ0dzNrU05vMm9FalFHazNtOXF6?=
 =?utf-8?B?Q2NSS3p3ZmcxSDN5eDFtNXZBanMzc0tUU0l1YVorZlN2UFVXczk1bFFGbCtB?=
 =?utf-8?B?c3hDUi9ScFRBSmorNXZzdk9hZ3Y2MUN5dDlMTnpmeUhtOHp1ekpJbU41U2NY?=
 =?utf-8?B?QlRXOWo1WjR6dk1MT203dVhreW45cHdNV2pQNDBIcXpFQjQ0U1BHblVwdG4r?=
 =?utf-8?B?ZG41OHc4dnRhUmFRVmIvam9wVTFGZEx3VVpYZGVxSThQaE1hU09HRExoclVF?=
 =?utf-8?B?ZHZZR3V3TmFsR3N3UFlzbXU5OHZtUW1DY2d2QkhTbUEyZndia0Z3TlZFNWk5?=
 =?utf-8?B?YlBlZm9KSktJYlMxTnFnbGFHa3RsdHU3K1hPWGVCa2svRVUrR1JmZmxiQjVv?=
 =?utf-8?B?Qnd5WVI5NzhFUlZyRzZsdXdLZTBVY0NlcHMwM21lTDNtNVJMaVBCa25XYUZT?=
 =?utf-8?B?QWJBalhudWdvb041VXFtMlhtNkJqMlBvMzR3eTVzL3dCb3gxTG1uUXVzZmhq?=
 =?utf-8?B?Y3psWnVDQk1TbGlnV0dINTZvbEd4Zm1tUUY1OWpMaFEvUEhqc2dzYXhBV01t?=
 =?utf-8?B?eTA1R0FJQURBbzBWdUJTRThzZ2F1RUN3WW43N3ljU1Y1cWZ4TTNVYTdWM0tR?=
 =?utf-8?B?MDFqZi8rU2xhOFJ1TFFKZlJ6M1hjVXUrSW0rYmh2OXh4SEdxbDdlNC9CdFpq?=
 =?utf-8?B?ZngvZ0R5ZkVmUU9wWlNBSFpQaFNrTk90NUJlS3YySVhRU3dLemtlZUdZelRG?=
 =?utf-8?B?WWFjZE5pVjVTZWxFNmtTWVdUb2JHb0kvVTMxYSthc2VJdm5KTUpia1dyTDho?=
 =?utf-8?B?bytoaGlCZEZwREVXWjVEbTdVMnFYY1VOMzB3YnJNRWZCUzMrMXJLWVJTMENx?=
 =?utf-8?B?T2UwOFlKd2xWS1MrY3ZhTFNHc0cyQ3ZDQTJmZlVjZDdkTHNVWnhnWG1EeDZX?=
 =?utf-8?B?bklUaU9odmVmN2JzYmEwaUJhcnZXSG4zR2I3bGw3ZzM2YzE2a0hTRnNqa3ZT?=
 =?utf-8?B?U1gwN2FpV2RWUmlORTRESE85UDNEMWM2bklJb0NiSEs5NzNocE9pZ2ZweThH?=
 =?utf-8?B?aGZ1SGlIbWQ2YVM3elo0cGlUQkQ1YUFHZlhjNEFQTXBJL2J1N2o4RHlncVlR?=
 =?utf-8?B?cWZwa2FJODVzeTdxb1VBZkVuQ1Z4dzNBWHk0N3gweUQ5QjlJZ0p5Z1VrQXor?=
 =?utf-8?B?Z0ZxME9YTTFtbUFkNHpIUWh4elpqZ2g3Z0hlaVNKL2xDYWlXQ3ZBekRVTnJO?=
 =?utf-8?B?dldPbEhmMUI2Y0s3U2pkNFBRazRuNDU0WVJsU2VTUUJLQmh4OVJ2aS83RWVl?=
 =?utf-8?B?RkUzRmRUUWZCa3p6OGVIWGRzRWxOSXNSNERJUTV3Q1d6ck5neFpGQjNneDlh?=
 =?utf-8?B?dFk2SGx0U08rUElZZjNRTkZxZk9ZOXNzcEI2eno0WXd4dStnYm5tOFZ3TEVk?=
 =?utf-8?B?Q1JSMEo3T3RXQWlqcDVvd0t5SGs4VU9yekcxWVZmSmZsRFNJNmIzb1pYdGZm?=
 =?utf-8?B?M21jRUNSZmIzV1JXYjYxOWtiazFWRVFrTzROYnlwWG1DTDcwK3hjYXdxbUQ4?=
 =?utf-8?B?Tm00cyt5YnkxWUJkSFk5QmxYWDFRcnVZc1lSVEZaT1UvUHNTMGFYQ3Z4TWhY?=
 =?utf-8?Q?uoSJ54RFYy6pAVJZ9I1ugAXMc7wmW28HFFt1ftOrCcfB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5880819-1706-4bd1-cd99-08db9313d9b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 04:49:26.9141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f2MgKnA6a+7ver6x6kv7jLRtdeE2cGFO5vPNK4DENNvxXNIQtQvMCUXX4Imw/Jmw1w/u0zgDha9fOSrgkxJzAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8275
Subject: [virtio-dev] RE: [VIRTIO GPU PATCH v3 0/1] Add new feature flag
 VIRTIO_GPU_F_FREEZE_S3

DQoNCj4gRnJvbTogdmlydGlvLWRldkBsaXN0cy5vYXNpcy1vcGVuLm9yZyA8dmlydGlvLWRldkBs
aXN0cy5vYXNpcy1vcGVuLm9yZz4gT24NCj4gQmVoYWxmIE9mIENoZW4sIEppcWlhbg0KPiBTZW50
OiBXZWRuZXNkYXksIEF1Z3VzdCAyLCAyMDIzIDg6NTEgQU0NCj4gSGkgYWxsLA0KPiANCj4gRG8g
eW91IGhhdmUgYW55IG90aGVyIGNvbW1lbnRzIG9uIHRoZSBtb2RpZmljYXRpb24gb2YgdmlydGlv
LWdwdSBTMz8NCj4gTG9va2luZyBmb3J3YXJkIHRvIHlvdXIgcmVwbHkgYW5kIGNvbW1lbnRzLg0K
PiANCkkgYW0gbm90IGZhbWlsaWFyIHdpdGggdGhlIEdQVSwgc28gYSBkdW1iIHF1ZXN0aW9uIGlz
LCB3aHkgdGhlIFMzIHN0YXRlIGlzIGdwdSBzcGVjaWZpYz8NCkNhbiBhIHRyYW5zcG9ydCBzcGVj
aWZpYyBzdXNwZW5kIHN0YXRlIGJlIHVzZWQgYW5kIGFwcGx5IHRvIGFsbCB2aXJ0aW8gZGV2aWNl
cz8NCkFuZCBjYW4geW91IHBsZWFzZSBhZGQgYm90aCB0aGUgcmF0aW9uYWxlIHRvIHRoZSBjb21t
aXQgbWVzc2FnZT8NCg0KPiBPbiAyMDIzLzcvMjAgMjA6MTgsIEppcWlhbiBDaGVuIHdyb3RlOg0K
PiA+IHYzOg0KPiA+DQo+ID4gSGkgYWxsLA0KPiA+IFRoYW5rcyBmb3IgR2VyZCBIb2ZmbWFubidz
IGFkdmljZS4gVjMgbWFrZXMgYmVsb3cgY2hhbmdlczoNCj4gPiAqIFVzZSBlbnVtIGZvciBmcmVl
emUgbW9kZSwgc28gdGhpcyBjYW4gYmUgZXh0ZW5kZWQgd2l0aCBtb3JlDQo+ID4gICBtb2RlcyBp
biB0aGUgZnV0dXJlLg0KPiA+ICogUmVuYW1lIGZ1bmN0aW9ucyBhbmQgcGFyYXRlbWVycyB3aXRo
ICJfUzMiIHBvc3RmaXguDQo+ID4gKiBFeHBsYWluIGluIG1vcmUgZGV0YWlsDQo+ID4NCj4gPiBB
bmQgbGF0ZXN0IHZlcnNpb24gb24gUUVNVSBhbmQgTGludXgga2VybmVsIHNpZGU6DQo+ID4gCVFF
TVU6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyMzA3MjAxMjA4MTYuODc1
MS0xLQ0KPiBKaXFpYW4uQ2hlbkBhbWQuY29tDQo+ID4gCUtlcm5lbDoNCj4gPiBodHRwczovL2xv
cmUua2VybmVsLm9yZy9sa21sLzIwMjMwNzIwMTE1ODA1LjgyMDYtMS1KaXFpYW4uQ2hlbkBhbWQu
Y29tDQo+ID4gL1QvI3QNCj4gPg0KPiA+IEJlc3QgcmVnYXJkcywNCj4gPiBKaXFpYW4gQ2hlbi4N
Cj4gPg0KPiA+DQo+ID4gdjI6DQo+ID4gbGluaywNCj4gPiBodHRwczovL2xpc3RzLm9hc2lzLW9w
ZW4ub3JnL2FyY2hpdmVzL3ZpcnRpby1jb21tZW50LzIwMjMwNy9tc2cwMDE2MC5oDQo+ID4gdG1s
DQo+ID4NCj4gPiBIaSBhbGwsDQo+ID4gVGhhbmtzIHRvIEdlcmQgSG9mZm1hbm4gZm9yIGhpcyBz
dWdnZXN0aW9ucy4gVjIgbWFrZXMgYmVsb3cgY2hhbmdlczoNCj4gPiAqIEVsYWJvcmF0ZSBvbiB0
aGUgdHlwZXMgb2YgcmVzb3VyY2VzLg0KPiA+ICogQWRkIHNvbWUgZGVzY3JpcHRpb25zIGZvciBT
MyBhbmQgUzQuDQo+ID4NCj4gPg0KPiA+IHYxOg0KPiA+IGxpbmssDQo+ID4gaHR0cHM6Ly9saXN0
cy5vYXNpcy1vcGVuLm9yZy9hcmNoaXZlcy92aXJ0aW8tY29tbWVudC8yMDIzMDYvbXNnMDA1OTUu
aA0KPiA+IHRtbA0KPiA+DQo+ID4gSGkgYWxsLA0KPiA+IEkgYW0gd29ya2luZyB0byBpbXBsZW1l
bnQgdmlydGdwdSBTMyBmdW5jdGlvbiBvbiBYZW4uDQo+ID4NCj4gPiBDdXJyZW50bHkgb24gWGVu
LCBpZiB3ZSBzdGFydCBhIGd1ZXN0IHRocm91Z2ggUWVtdSB3aXRoIGVuYWJsaW5nDQo+ID4gdmly
dGdwdSwgYW5kIHRoZW4gc3VzcGVuZCBhbmQgczNyZXN1bWUgZ3Vlc3QuIFdlIGNhbiBmaW5kIHRo
YXQgdGhlDQo+ID4gZ3Vlc3Qga2VybmVsIGNvbWVzIGJhY2ssIGJ1dCB0aGUgZGlzcGxheSBkb2Vz
bid0LiBJdCBqdXN0IHNob3duIGEgYmxhY2sgc2NyZWVuLg0KPiA+DQo+ID4gVGhhdCBpcyBiZWNh
dXNlIHdoZW4gZ3Vlc3Qgd2FzIGR1cmluZyBzdXNwZW5kaW5nLCBpdCBjYWxsZWQgaW50byBRZW11
DQo+ID4gYW5kIFFlbXUgZGVzdHJveWVkIGFsbCByZXNvdXJjZXMgYW5kIHJlc2V0IHJlbmRlcmVy
LiBUaGlzIG1hZGUgdGhlDQo+ID4gZGlzcGxheSBnb25lIGFmdGVyIGd1ZXN0IHJlc3VtZWQuDQo+
ID4NCj4gPiBTbywgSSBhZGQgYSBtZWNoYW5pc20gdGhhdCB3aGVuIGd1ZXN0IGlzIHN1c3BlbmRp
bmcsIGl0IHdpbGwgbm90aWZ5DQo+ID4gUWVtdSwgYW5kIHRoZW4gUWVtdSB3aWxsIG5vdCBkZXN0
cm95IHJlc291cmNlcy4gVGhhdCBjYW4gaGVscCBndWVzdCdzDQo+ID4gZGlzcGxheSBjb21lIGJh
Y2suDQo+ID4NCj4gPiBBcyBkaXNjdXNzZWQgYW5kIHN1Z2dlc3RlZCBieSBSb2JlcnQgQmVja2V0
dCBhbmQgR2VyZCBIb2ZmbWFubiBvbiB2MQ0KPiA+IHFlbXUncyBtYWlsaW5nIGxpc3QuIER1ZSB0
byB0aGF0IG1lY2hhbmlzbSBuZWVkcyBjb29wZXJhdGlvbiBiZXR3ZWVuDQo+ID4gZ3Vlc3QgYW5k
IGhvc3QuIFdoYXQncyBtb3JlLCBhcyB2aXJ0aW8gZHJpdmVycyBieSBkZXNpZ24gcGFyYXZpcnQN
Cj4gPiBkcml2ZXJzLCBpdCBpcyByZWFzb25hYmxlIGZvciBndWVzdCB0byBhY2NlcHQgc29tZSBj
b29wZXJhdGlvbiB3aXRoDQo+ID4gaG9zdCB0byBtYW5hZ2Ugc3VzcGVuZC9yZXN1bWUuIFNvIEkg
cmVxdWVzdCB0byBhZGQgYSBuZXcgZmVhdHVyZSBmbGFnLA0KPiA+IHNvIHRoYXQgZ3Vlc3QgYW5k
IGhvc3QgY2FuIG5lZ290aWF0ZSB3aGVuZXZlciBmcmVlemluZyBpcyBzdXBwb3J0ZWQgb3Igbm90
Lg0KPiA+DQo+ID4gSmlxaWFuIENoZW4gKDEpOg0KPiA+ICAgdmlydGlvLWdwdTogQWRkIG5ldyBm
ZWF0dXJlIGZsYWcgVklSVElPX0dQVV9GX0ZSRUVaRV9TMw0KPiA+DQo+ID4gIGRldmljZS10eXBl
cy9ncHUvZGVzY3JpcHRpb24udGV4IHwgNDINCj4gPiArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNDIgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+IA0K
PiAtLQ0KPiBCZXN0IHJlZ2FyZHMsDQo+IEppcWlhbiBDaGVuLg0K

