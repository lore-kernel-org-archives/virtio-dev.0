Return-Path: <virtio-dev-return-13870-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ECA5CE79B0
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 10:55:18 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id CD51E12D353
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 10:55:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A495B986679
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 10:55:17 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 886F9986669; Wed, 20 Sep 2023 10:55:17 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 78BE198666A
	for <virtio-dev@lists.oasis-open.org>; Wed, 20 Sep 2023 10:55:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/g3eg0EhcZK8aJTqez+SF97w7EgCavYGVQMZMv8VywO0qjACvKOK79auxJFhY7/6xCm3IwjYMNgieA02w8A7vRQano5tWvXEeqDY/o6UmWcEgvFHg+kmS9rOm/IOIl/EeKNxRM4pkgr3VOMS1QndDWRjUj/ebTUtwMMLdauqFrrj1FZdryGCzFbH6XytiW8IDbXWNqNWlFAYRg5vopbnQ9hmxyGsVb5ctjLPcwGXL6LfyeXwpIg+axWlZsw3JtYRHHoRBntLzmgT57+gRsj98QdjITHo7I4TkJ+G5i4AJ99oJ5hqrp9tJJBGBU9tjzLHiZxKNenQJ/ClqUAZU8GpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4XmGW9p08zZPYMCarGVy8eRViPf+e5BMrBvdxwS9f3U=;
 b=PvR236kQzkN1kgGrnQxFNx/j3cqtJMxdrslJBDODXJUy/cKWP+zbUWIO5inJZvqi71jDuHpAQUzL5z02mvvn85NAnlgUEJnH71pdXjAKEp8iWC320cAPATG985SgSOELDF319Ky9dzwCOMTE0Qtaq3NK5WEnXVpxudma+7yQEqa8PrEUGqTdAGmGCxJGs6XAv95iXqJWjTUe8qihgnRWsRZe3ar0/ycOMp8kiul2pxWZUf4WWhKLYEu/BDugBNTctjVotwHB5PKHENq2r4jQ2+b9KP1ViAusvPx4E3pngxNshfJlNfaODF+RfI9EpFdNK4hkkETmzQvqQF/vkRv5pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, "Zhu, Lingshan"
	<lingshan.zhu@intel.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Jason
 Wang <jasowang@redhat.com>
Thread-Topic: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and
 vq state
Thread-Index:
 AQHZ540fvvI9R/h+mUufqKbomRy5frAegLUwgAFrbQCAABUsgIAAD5cAgAAA+ACAABKeIIAABNaAgAAAXmCAAC3dgIAAl98QgAADDoCAAk+KgIAAS2wAgAACd5A=
Date: Wed, 20 Sep 2023 10:55:14 +0000
Message-ID:
 <PH0PR12MB54817E095D0F3F86A9D1C3DADCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
References:
 <PH0PR12MB5481C41D4F32DA26D5831471DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <67680965-b115-32c7-dfdf-c56ab37bdd81@intel.com>
 <213a0f94-cee2-d8c5-3c5d-d2d7fc920e75@intel.com>
 <PH0PR12MB5481AE8C6E5EAFE9A4ADA6F6DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <f1fe513e-d42d-03a6-348c-5e58aac0a759@intel.com>
 <PH0PR12MB5481323A3B4D67EB66328476DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <5f01772f-eb27-bfe0-7f69-b83fbd90dda0@intel.com>
 <PH0PR12MB5481ABF4B9BC2082BC54AB1DDCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230918144312-mutt-send-email-mst@kernel.org>
 <bb402c34-ad07-063a-f4f5-d8c6b3a642c7@intel.com>
 <20230920054836-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230920054836-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MN2PR12MB4128:EE_
x-ms-office365-filtering-correlation-id: b42f2bf1-0a2a-44e1-e8ac-08dbb9c81193
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Jb/AcuSwx9wpS+mdTU5cIPCK5UA7fePP8aWXJ+FCCXWDLrnLTmD9rXJGUCE9QD1A+vw4GD8GcjHkya7Vpd4cGEQtZG1G0EinFzgUBmNCNHMnQjFTWs1mlkkINMf721Ku0uX0c38EUa2JtFz9eWTPSU1IiISMBT2yWP3Xiwn/7Z5GY0TIDMiK6dRLMjutC/1WxWrMFbI0IAbhTbqJeSZBU8zP5mRn77mwx+XUFVxt19n1DIj/Cj27euoWL6fxLU0cUwQZy/Uah5DmCaLLqiCJA5N4ATNPni6A4+dusm4LsUi0tn2APKuS51RsOq2HDIWnGMiNouOf7Pz6BA8Zf963moSSTJ/kAQoB2CWdOesC73tCpSfMxcgObBUdV31RLVrjaF1JLHXpUg3YNlssJ4A15a60Y6zlTJKCPgoBCGK5+TUXEMmZaZxNSF35JDTABBoBDT+/YdtHPyRAG4Dhm/Ht6tioyLmk5Bv4BTvleFIFtJ8bHzyBiBLyC52QIFbEik55ATxrAlqEtRRuezFS1EuFhym4sYHB1A8iq9UTKUpmbqTVW0FlnDWBEtzVOXChAmHpUvaixFyAhAXTfOGj3AdPpOukuNGeroNuf4gREDBkcLuB+ea2SjXrxo1xwI1NV6rLZBeYj6utqBvADhFgYz1aOrdynNdEsxUzHFRyWw7jfJc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(376002)(39860400002)(346002)(1800799009)(186009)(451199024)(52536014)(26005)(8936002)(8676002)(122000001)(33656002)(4326008)(83380400001)(2906002)(55016003)(86362001)(7696005)(6506007)(71200400001)(966005)(478600001)(5660300002)(316002)(9686003)(54906003)(38070700005)(110136005)(76116006)(64756008)(38100700002)(66556008)(66946007)(66446008)(66476007)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8iuXXpRgaZcoIao8pMka4Ygn1wbkRoZ8g3Xh+OnuKHplgL1giFH1UVYeNfaI?=
 =?us-ascii?Q?VFt0Ft4mSllsSXjNwZp6v9iH8yf/1Xj/gMB/jrTJR+9m/BbZUswQG4E6T+01?=
 =?us-ascii?Q?vahEgnWPYjLRlnilaKHdylRvShjjQpeSXrNBAOw4O9OiTjvyXBP11I2KGcfq?=
 =?us-ascii?Q?aMPg0toOKDE3RTcVYSsturIIzBH2lcpa3ICzo2abq0LKPiFnyXR9yT7zFLU0?=
 =?us-ascii?Q?RxbI966+Fu3U+Cby2Ia1tAahJyNVlfv9qo1FK63IFeGG0FsiU6FiViQ5Ofa3?=
 =?us-ascii?Q?9HZfZfUOOoIdTSv3TKFTSEi2WKtDC2GpEimLkzdVCWdFDBLGcoXs37Jm5M7C?=
 =?us-ascii?Q?liVT84WktuKJPXzgbEeM4ENmM5QFgElQ3icee/N95ie/TSrnqWSENoC7Pody?=
 =?us-ascii?Q?3WCgUXliwwGcdgGPR/u2q5eiluVf3vdJrGFxFQ9Q54Jlcc3ii/zXj7n2tLbX?=
 =?us-ascii?Q?0OZBwvBcrfbQIRLUVX9/t5Vy6ZEf25MjaYL+d7gmbqhbEg7bTF17VTQpnPq+?=
 =?us-ascii?Q?ab9waA/l90Rf+f1HbTFejRoni+9vx+AFZ98ljuk5YwAWrTffDzZA6CqLL5rI?=
 =?us-ascii?Q?G8hY3zncyp2TlOZgEIPcpZfhzYyCxM7yEOV8MKGYkvUQeEaNTA2+vefQY/Xd?=
 =?us-ascii?Q?QIhdUDjf8EEPIqWbTC5BifMn/E/41tK0PZajWEFkzFhj6Rqg5gG8qap73KCI?=
 =?us-ascii?Q?AswsBpseFiOWTtkdV/SOSI5hXpVFafiSr7aAx4FUXaqvDBnSNzzzyGTLGyhO?=
 =?us-ascii?Q?b6aeMGu8Zo4WZyX9aqjiRI26Fbr01nEfguY7kEzSFc5LzJDRU7IHNIt+tQu1?=
 =?us-ascii?Q?QI9ObpNaKS8JUS+dBknr2TgFouXPPqhWMJ0mevQs5FLMCDpcYcckl1xHBBLV?=
 =?us-ascii?Q?HzO+8DtbV1zEoHXOP8m94XR+kNVU72x8ZhQaclg7AQ0x4GDKhkFIyRY1NjG7?=
 =?us-ascii?Q?8yKyexwiz29vhKi396fKL6W8CnWoqsa5csVVj3P10tC4Krp4+UrsXzHaIdoI?=
 =?us-ascii?Q?ZmGDYR4FNizUVttMhj0NQv/iTLA+cMMTmXMAmZx0rWw3fSlp8K1aFDYAa/wF?=
 =?us-ascii?Q?oTAEKziF85RPlGpon/yGeGFJExB03vgRou4kNXHdlt641rBQcqDpcTwZp5dQ?=
 =?us-ascii?Q?j9W6PkbnldiETQahcMORQdPmWKU/lTO+3vXUX8oWtLU/F3soP8UuwCeXFVAG?=
 =?us-ascii?Q?EiSA2HDOJDDhMExiFMVFkqaVSHdbMggJvfRMC7zYtePDgo67IwLzTdtaWVx0?=
 =?us-ascii?Q?7Eb3TNTy5wWqYJBPxHTI2Ongj3B7TmxGj0xLj4Zoi2gJCWSPQ83PdruFE+ht?=
 =?us-ascii?Q?RVXlvhF7Thv5t9GjaAMUqXXh9Fa8EdNqEzu5QpzC+xDK4vTZKtWR9rqeAfQp?=
 =?us-ascii?Q?7My4Zw6xp3UGFdgjzUL6QxdZNm1WpP6sZeHSLAsKc2PJo0HXWKD7r2mLMATj?=
 =?us-ascii?Q?DNo4W6BnGLN3ZAcYtUOw9iNpuR8Ttk9CaoFZ0ID+mwKtLiNvUUl/oJN9i67y?=
 =?us-ascii?Q?zPeCytDkjurPV9TYgtcM0pKRhyHBzVqUuL1zoX2SJvtIxnkwYG9XNuneXirF?=
 =?us-ascii?Q?zD6PMYies62A8XYe9rQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b42f2bf1-0a2a-44e1-e8ac-08dbb9c81193
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 10:55:14.2357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Awrn86c6l66SNJzLXT9gB6t2C28cgyJD+QcihmoqpZXeMi2OzXtkGZaltH6VjMb2EpXtorXcsDxar4hKCu75HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4128
Subject: RE: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq
 state


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, September 20, 2023 4:06 PM

>=20
> I freely admit the finer points of this extended flamewar have been lost =
on me,
> and I wager I'm not the only one. I thought you wanted to migrate the dev=
ice
> just by accessing the device itself (e.g. the VF) without accessing other=
 devices
> (e.g. the PF), while Parav wants it in a separate device so the whole of =
the
> device itself can passed through to guest. Isn't this, fundamentally, the=
 issue?
Right. An admin device doing the work of device migration. Today it is the =
owner PF.
In future it can be other admin device who is deleted this task of migratio=
n, who can be group owner.
All the admin commands that we plumb here just works great in that CC/TDI f=
uture, because only thing changes is the admin device issuing this command.

>=20
> > the bar is only a proxy, doesn't fix anything. and even larger side
> > channel attacking surface: vf-->pf-->vf
>=20
> In this model there's no pf. BAR belongs to vf itself and you submit comm=
ands
> for the VF through its BAR.
> Just separate from the pci config space.
>=20
> The whole attacking surface discussion is also puzzling.  We either are o=
r are
> not discussing confidential computing/TDI.  I couldn't figure it out. Thi=
s needs a
> separate thread I think.

True. Many of Lingshan thoughts/comments gets mixed I feel.
Because he proposes trap+emulation/mediation-based solution by hypervisor a=
nd none of that is secure anyway in CC/TDI concept.
He keeps attacking AQ as some side channel attack, while somehow trap+emula=
tion also done by hypervisor is secure, which obviously does not make sense=
 in CC/TDI concept.
Both scores equal where hypervisor trust is of concern.

And admin command approach [1] has clear direction for CC to delete those a=
dmin commands to a dedicated trusted entity instead of hypervisor.

I try to explain these few times, but..

Anyways, if AQ has some comments better to reply in its thread at [1].

[1] https://lore.kernel.org/virtio-comment/20230909142911.524407-7-parav@nv=
idia.com/T/#md9fcfa1ba997463de8c7fb8c6d1786b224b0bead

I will post v1 for [1] with more mature device context this week along with=
 future provisioning item note.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

