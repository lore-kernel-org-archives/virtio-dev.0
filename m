Return-Path: <virtio-dev-return-12223-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9074C77B61
	for <virtio-dev@archiver.kernel.org>; Fri, 14 Apr 2023 03:14:00 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1D66E419B1
	for <virtio-dev@archiver.kernel.org>; Fri, 14 Apr 2023 03:14:00 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0F1A698661B
	for <virtio-dev@archiver.kernel.org>; Fri, 14 Apr 2023 03:14:00 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0261B983FEA; Fri, 14 Apr 2023 03:14:00 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DDB81986600;
	Fri, 14 Apr 2023 03:13:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=htqQ2EIHgnNcTUbNoAPnOUu485hnWc9VF8NWprmlsbG7CbIpqmzUggT+7ickgLJgqMG/lxKu/krIGwq7/WX0j2Ldbbtsz5dF71rOuIzYDkf5Ej5XbSzGQRUS8wrhyLva2TL93qh+ki4pEMdw/eDfPevSDx1AWqMqpbod0KH9rWfGyv3vnjAmxV0Q6tNxNrNnt/31uDDSLhqWXiSQOY3eaLXlU+MQGsrVQ/ibdLPpCRYiNjBjhTRxUcFzzU4FZzd1zGjPJqF5SCRyhcez+xXDqCTL9+vyOqK/cmxU/Eaym1aw6zJvMr2suxXtJXSr9bXclXrJ/foNuawaOiiTrvuWoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/7onfq+VTNVaQK8xzPPonSy4Pytgr3q9hecquLu0aNY=;
 b=C4OQmqf+b6U3PIXPVn6gx0gxMre8cv3U4ZR9u/o814YW4xnLspMe6hCE0xO7Rz9pMfFnml+6m3iyeW6zbdDBm18lfBL1O7ik/8+7TRmldhdQee6bN/hc2yH2Cm6wMcWZmT5fme7y4V/xzbuRwpueYEwVX6kdMz6iGoUQLkwcFVWya3RJD/FKz+KhZQ0xVgjWl3djxSjN4gImD8bOS8DqU6McFkc/ChoVPNh2PMT//Rm+X1vBpu9EDnr+gO6sqL1ObQUZ4kTu+CdUpKUz7PM2JK4JFk28AQm5DBDKlnUG32vLBWXoiC5uqYoxGMqiPHsA6eLZS2n0TMQpsQAlkNgkHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>, Satananda Burla <sburla@marvell.com>,
	Maxime Coquelin <maxime.coquelin@redhat.com>, Yan Vugenfirer <yan@daynix.com>
Thread-Topic: [virtio-comment] Re: [PATCH 09/11] transport-pci: Describe PCI
 MMR dev config registers
Thread-Index:
 AQHZY1tLAUtRpuZtUUOucQPGJlFfkK8flpUAgAQ7nwCAAE6hgIAAAXwAgAAFegCAAAt0AIAALl6AgAEOIwCAAFEgAIAAIPWAgAAcJ4CAASFtgIAABJ4AgAAKJYCAAACFsIAABgyAgAAAT3CAAAYpAIAAAJIAgAAJz4CAAILBcIAAxPiAgAAc1wCAABy4gIAAzAAAgACjPgCAAADPkA==
Date: Fri, 14 Apr 2023 03:13:48 +0000
Message-ID:
 <PH0PR12MB54815F0A67A14691CA64D2B4DC999@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230410020906-mutt-send-email-mst@kernel.org>
 <CACGkMEufWUXHKahg3GLOKfV5aptbiek_DKwy+7rCfMya2GPaTQ@mail.gmail.com>
 <20230412000802-mutt-send-email-mst@kernel.org>
 <CACGkMEshNydwBD=Q0JW-SDY6xyiJ4uVrLn+pxbUrinycBKwsrw@mail.gmail.com>
 <PH0PR12MB548118F57BB4B4A4F8DC9D7ADC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEvYsz1fSPG+fKpRaZ05Ut7ffKwvMPvR8xbRBsXA_6vGQw@mail.gmail.com>
 <PH0PR12MB548137D7A25C99EAA42B4D12DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEshW82qztmGw8YJWJ8=QCoRd6cPxQ+ySazxsO_o+U6c4Q@mail.gmail.com>
 <PH0PR12MB548147CF939CB9C2A0586310DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEu2B_GogDR9HUwB7mT8fkGh+Q_buPLz4nhwhK7h9k6BQQ@mail.gmail.com>
 <PH0PR12MB5481F0CF5A555A6BB2CE856CDC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEuNOYOxvcSzrs0UFEyk+xOkGUpOfhK8rOy_Mebz5b5wdg@mail.gmail.com>
 <a74d3107-d38c-df15-e2ff-f848635f24bd@nvidia.com>
 <CACGkMEt+bGN7UYEopXPj0+deAnYm1VUNp05VvGHcJnkd8LzbGg@mail.gmail.com>
 <f9f01f9d-f6ec-0daa-a11d-c75589dcbe6c@nvidia.com>
 <CACGkMEskPJgNrBQV10ieSaKCg_kBbi2E0z1BEbdyiiaDdD1zJA@mail.gmail.com>
In-Reply-To:
 <CACGkMEskPJgNrBQV10ieSaKCg_kBbi2E0z1BEbdyiiaDdD1zJA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CH2PR12MB4971:EE_
x-ms-office365-filtering-correlation-id: 18a77200-a3d9-492d-b7af-08db3c9643ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 vS7hk8ht2zf7naIVZy6oNJwvAT2OSng46wMc0uBWR65Du/yHtf6G0ne7TxRIqiNeX3RWZpIzw6IQke4IbT48CULAzd1abNsfXvrb/LS0HoWhpDRdMwomIg7ZUW+HTyI1ogOe/2wjE9VqvlNvhX+BzuAHiL/UAWnwYLQGFYlSCSvhX2SZWkBSL59maE/e0gPc2kbDQ68YJkPJkRILRF8v6m9cSzxFtAp5MIEu8FGxAYASUkuqx7F6OonBc7xoWyHgb0o5qYAAk6jHndXOLdO3gEVIsLJ0tDmnHzLhkYTkSMZKebWEQrAk8KC5ZxjvPUXCkaon3hEa5cMedG5ax6F6USCylkpJBfWqka0OB6WiKfGtVgQRY079dKdLqIa4xU1pigDUaB6xPHXVA9tLDYGu1J+y9Y5lE/5Lm5vuroDjKLqv+U3StrGTPPxN0A/rjd6evvkbqhGz18VEmBquibwPSCbMuDscRpKrGDi8MGrniQeBkhE0xp7annYkob5QFW2nr+VXjNAlp3zkd7lIrD/DYp2x2LK3yHtKeFQY9/Teem4yPoR3WsjiN3CsN+XUBMaL8j/A/lUm9+KVg2kzULPMZ449UnYMZo83J3qQm68XhMw8/9kkTheXyQu0rDdQ74hY
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(366004)(39860400002)(376002)(451199021)(38070700005)(26005)(76116006)(66476007)(64756008)(66556008)(55016003)(66446008)(6506007)(9686003)(71200400001)(2906002)(4744005)(7696005)(186003)(66946007)(6916009)(4326008)(54906003)(86362001)(5660300002)(52536014)(8936002)(122000001)(8676002)(38100700002)(33656002)(316002)(478600001)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dTQrZUtRcUJ2MnEwd1h2VWd3d2puVURVbkZDTkJ1RFAvSE5zZWc1RStMVWtI?=
 =?utf-8?B?cUI2ei90RXVYQW1nc2g2cUt5R1hzZjM3d0oxTmtXZU9Zc0ZGRi9SUHVTZnd5?=
 =?utf-8?B?RzlHZTd0ZjBrOFBtMmVzZm1rZlFFZFJ3bUNQYUFVYWw0anFvbmF4WlpHcy84?=
 =?utf-8?B?OHlZL084dm9HZXJSYVpvY29IeU1GVVRDaGp1RDcvTWtCejBnRHlmZTJPd29a?=
 =?utf-8?B?eEw5T0FRRncxbUFlRVFCYnMrS2IrLzIybkpYeUNlTHYvOE1vbmFJL0xnZjg3?=
 =?utf-8?B?NGxLd3k2dTFUMmphbkEzcUM0MXRwa09xVzQ4bTMvQ3NwdmNuaWd2QVh6ODNl?=
 =?utf-8?B?aElUclhvVVNRbjlVczBFRExCTzd1TlJGUUpURGpCSTNOK3IxL0c0OFN5ZWI4?=
 =?utf-8?B?RkZrcXlsNGxjTVN0MDViWFF2eXpNN29zK1VIZGRMOFNXRW9TZWNja0tyTGJs?=
 =?utf-8?B?R2tBQWVOZ29GTDhya3ZSbmJRVm53OTRVU2djM3pZM2Q3cC9YdnZrdjltb3I4?=
 =?utf-8?B?bERkUU1yV2FDUmxJL0lEeGpBQU5PckJOWi9yWUlkR3FVdml6dFV3OHdLTUQ1?=
 =?utf-8?B?QytSSFRsK3d3RkE5WjVJTVFQYzVmMU9ybzEvVEg4czBzNzRXZzRIeFdQcjhj?=
 =?utf-8?B?c0pIcVgwcW5rc3IzQ3NuTXZ1T3lhTzNSQVYzVC81L3B0amZDVm1jZVRab2FX?=
 =?utf-8?B?RUhDRjNwRnpHZUd1M0IzNUNkdWlDcThNbHdRa2t5U2pZdE1SRjBTZ0FZN1ha?=
 =?utf-8?B?RGN2RHQ5VGVhU1hDcnQ3UmZOdG1nMWwrNmFWelpaSG1JcWc0eDVKRHR3Q0Zh?=
 =?utf-8?B?WEhybXVVOGh4NXZZalFHSDJBcW1yWkJ0ZVp1c0FtN3RlbEl2aHBhMG1yOG9O?=
 =?utf-8?B?NHZDVnRjcUdkY2hMb0F1clZ6VFp5aUhwb3ZpRXlvdDdLNEI3dm1wZkhZM0pD?=
 =?utf-8?B?ek9jN2p1MGd2T3dEQVFQN2VTbzBQMG5aNnRTQTNOMUNYak5YaUVYTjJnZDdt?=
 =?utf-8?B?UHYzVXVZRGpqVWdUS0pXSEVNbmkxcEpjUXV0M2hBRzVjYS9kODJrVW9qYXdF?=
 =?utf-8?B?UUpGNjhoNVA4VnMwQlNSTDl5dFJWMXp5dVFoNXNiVFA1NEVOUUlBcGhESnhP?=
 =?utf-8?B?R1lHTnJzZkdCWS9kak83ZGZIOUJacnEzYlg4WmFsZk11YzVvbFZIWVJZVGt5?=
 =?utf-8?B?Q1RObURsTkp3TDBNMXRzVC9QMkw0eWNGQmdrTWZOQkJITE1sckw0S0NjRXh1?=
 =?utf-8?B?MEpJNTVia01TVUlsSHA2M1p5VHpOYXdUZDkxYWtnSmxaTDVxMFR1QjBaSEtN?=
 =?utf-8?B?Q2ZRNWhRNjd6L0R1d0JHamRRd1MyTkZqdlVRR3dIY2trSUZYYWF0d0JQSTZH?=
 =?utf-8?B?Ny9GU0x2QTRwREdQQzhpMlpzTk9rWjBzeTBBQmtOdXlUemNVREZuS084RWl4?=
 =?utf-8?B?N0dwQVZvUUFZdHpyL1dvMXE5YUdyL0RPWWxmempkUENjaFY3Mks5VWovMXZx?=
 =?utf-8?B?S1JQOTdwdHh6Z0N2RWxNVTFZN0NTRU1aeXdKSm5EK2lySlMyajFyR0I5aVhl?=
 =?utf-8?B?blljK0g1WGtLNDA0VWdFYlVLTUwzSy9jYm5LMllUZ1lKNE43SGxlUlIySnll?=
 =?utf-8?B?NmIxaGJ5NGdWYnh0RFk5Q0RSMVJRVGRwbFVPdDFMd0ZlYjgxelVFa3JXY05o?=
 =?utf-8?B?eVN4c3loVFJvbkQyVnZSNE41NUZTQXNmSE8rMVlDVmNKUjhvamNkYmIyZy9I?=
 =?utf-8?B?Y2VoYWg4RXpaTis2MTNYUkM2Uy9ybXdaMWlLVy8rSC9qcllhengwaEJyRmpR?=
 =?utf-8?B?RU9UY3NFdHBWKzkvYm9nUU1ZUkVRb1Z1a0xrNUxla3FwN1hxUEZUbmhSaCty?=
 =?utf-8?B?c0RTY016b1J1dmNsWUJUMkhtajE0Y3ljVUVheWdaUUV2NVdhejJSUmhGTjF0?=
 =?utf-8?B?Y25VRVZDUkZ1WVROWE5jYlNia3dMZUZOTWw5THFNeVVrVU9RYU9yZXhBREJu?=
 =?utf-8?B?NWR3NDZDeEJzNVZVcEJMQk1tdFdMWWJEVnVBYkc5Tnd6RXFycHJ0UHhyL3cz?=
 =?utf-8?B?c0tNYWVvYlF6ekRVdmpldzltZDJmWjNLdytHWThvNlR3TlFuTnV3aExtZ3cx?=
 =?utf-8?Q?EPac=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a77200-a3d9-492d-b7af-08db3c9643ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2023 03:13:48.4963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4046/JjB9SXB5oC7ufQKZ8AvYkmWicHNUkbu4GY0ZbhQiw8iUTqsOdCU7zml9fPUdYUr0//CE9xwEtHmWKH64A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4971
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH 09/11] transport-pci: Describe PCI
 MMR dev config registers

DQoNCj4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4gU2VudDogVGh1
cnNkYXksIEFwcmlsIDEzLCAyMDIzIDExOjA5IFBNDQoNCj4gDQo+IEFjdHVhbGx5IG5vdCwgSSB0
aGluayBJJ3ZlIG1lbnRpb25lZCB0aGUgcmVhc29uIGZvciBzZXZlcmFsIHRpbWVzOg0KPiANCj4g
SXQncyBhIG11c3QgZm9yIEFCSSBhbmQgbWlncmF0aW9uIGNvbXBhdGliaWxpdHk6DQo+IA0KPiAx
KSBUaGUgb2Zmc2V0IGlzIG5vdCBuZWNlc3NhcmlseSBhIHBhZ2UgYm91bmRhcnkNCj4gMikgVGhl
IGxlbmd0aCBpcyBub3QgbmVjZXNzYXJpbHkgdGltZXMgb2YgYSBQQUdFX1NJWkUNCj4gMykgUEFH
RV9TSVpFIHZhcmllcyBhbW9uZyBkaWZmZXJlbnQgYXJjaHMNCj4gNCkgVHdvIHZlbmRvcnMgbWF5
IGhhdmUgdHdvIGRpZmZlcmVudCBsYXlvdXQgZm9yIHRoZSBzdHJ1Y3R1cmUNCg0KTWlncmF0aW9u
IGNvbXBhdGliaWxpdHkgY2hlY2sgYW5kIGRldmljZSBjb21wb3NpdGlvbiB3b3JrIHdpbGwgc3Rh
cnQgZm9yIHJlZ3VsYXIgUENJIFZGIGluIHZpcnRpby4NClR3byB2ZW5kb3JzIHdpbGwgaGFkIHNv
bWUgbGV2ZWwgb2YgcHJvZ3JhbW1hYmlsaXR5IGFzIHdlbGwgdG8gbWFrZSB0aGlzIGhhcHBlbi4N
Ckl0IGlzIG9ydGhvZ29uYWwgdG9waWMuDQo=

