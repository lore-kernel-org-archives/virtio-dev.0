Return-Path: <virtio-dev-return-12482-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 466F4C77B7C
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 13:35:45 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 73BB81462C6
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 13:35:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 698BD9866A2
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 13:35:44 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5F313986692; Fri, 28 Apr 2023 13:35:44 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 48A1898668F;
	Fri, 28 Apr 2023 13:35:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JKu/pi9USuU1vjnjdS2Aa7omAaRZkGGz6ZrG18BiLEg+s4tahqE1arT/kecOHlJg7lY1wz4dF8rhOuV0+Mv/qZKNPMoaQLN5bsYLLuXdpdvUAf3fQxzSzVbGm9ttceR9BGCBp8se6heF6pHDsy+ip43vKNB0Y57pvgO6UBiJLpihGppfZ//XIZhMHoBYOAAPiDQq7GihLNn/l7T3f46hyPx0ZD3ZBudathaTSHI6lQKssM+XOoBhlnFmxsP7+nr17bcRAFH0a4Zf1iEYTynabw81/hVfo0FgJxDnDTjHYRS/YSwRoE86lEF8xA0qhlom2Jmfic1E2DTdYi56RTQCnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sLLjNIi4S7GiF9rRzUD7YuKWHPHjUWKQ6BKwhTDJdPc=;
 b=ARFGIZE2HA7piSFKAy5Ii9TLpKWjZfqza56cSvaBeL27efSYfQ0pRcbK6496inv/MTwgIU7DrQiW69uqositcLmWDWUVpQYKgsh2DQrU+/+kPvbOtUTzY5pXaApB65HoKgml/uwANBcIKkvsVENtKdRw/z7SM7P98VP+FxFLN9DhL0NZK/86VHKye9h2vB5euyrKSUXxRI3r3qUDHQd6J1on5oXWW2qMlJMkh15pXe0H0cSc7hDljW18/L/x+ctJg5W5hGjo2oUnVQWRy++qjlJiMOl0N78A4seYi9waTPJTEdB0uB2AC/o12C/t+koDokoftC+x+Efszn49nPo2HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v3 0/2] transport-pci: msix register desc improve
Thread-Index:
 AQHZdGE6BcXrBONjlkOC0QSro05TaK83HJUAgAN5WOCABY/KsIAACjmAgAAATYCAAJNpMA==
Date: Fri, 28 Apr 2023 13:35:31 +0000
Message-ID:
 <PH0PR12MB5481702B9992D7EC87045392DC6B9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230421145434.83774-1-parav@nvidia.com>
 <20230422061011-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54814D66357FCDAE3B3869DADC679@PH0PR12MB5481.namprd12.prod.outlook.com>
 <DM8PR12MB54809734DCE2820CA728AFA0DC6B9@DM8PR12MB5480.namprd12.prod.outlook.com>
 <20230428004335-mutt-send-email-mst@kernel.org>
 <20230428004638-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230428004638-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|BY5PR12MB4097:EE_
x-ms-office365-filtering-correlation-id: e81e1bf9-f85f-4169-eb0e-08db47ed702b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 wHpdVCg5iHVGiUwlOGUA5ksNqFM2TF11StHH/+AMgskwYoLwaTmcwmLsekRzd4Y6yeBd/p/TT0gf5wIJIX3rjHbDjn9P53MYLqMWkTPiLq/jIOuRaTOila2TypSfPgxZi9rdRFmcP+NKDaeNgmJwGcQmFWh5sPYyeJojtdLDJ5rcNTNWRy5xXfrYH3sv7CsB11AgFO1jWxjK8ZYFL5WzPLmyLS4MPoAI1XkmLUwYA0gZYYzX8+Zt1A8KSG8p8fryv4Vnz6z6N8oI4enzG0bxcsL9JhI8hs8OD90/hFsRfp2fNftHuPBmx3XRS9HBldgvTiPquBCPVwvzFLrY851RsY5SDctsHWEJco2eDpspgmF4lDCVCCvHBZdSFigQuJuHV6taNdgNhmKJCEypR5CabMOwMR35oDCXLuH/q7JxQT1R38ygATLu63a0OcnaODZ9p9lEMmPSeBfa0NpGS9ngOxp2FM9XLXLRsdCBuEkDcxLCpVLaBlixvFlc1xlLO7aDAuZf5Jmmce52bCsoKQ+ZEqZUGFxb4JST3JzZlOmem0pHA308Ge4QsAbNcXLX4KciE5mzZ0eQmH8lFwqga2CZnGAlILJ4c8jANTmfQtsNu9hcWXzhutHmz06mYbX/ncFsaV31EcoFfsOJkvSoJuuTiNVQqk87aVMmW89iMq5cEQE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199021)(107886003)(6506007)(9686003)(83380400001)(186003)(55016003)(6916009)(76116006)(41300700001)(38070700005)(4326008)(5660300002)(8676002)(8936002)(4744005)(2906002)(66476007)(66556008)(66946007)(66446008)(64756008)(52536014)(26005)(316002)(54906003)(86362001)(478600001)(7696005)(966005)(122000001)(38100700002)(33656002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BZJ2OW8hB7A5BAchQFHExlTEm41Ka2ZIllN6vsHi2t95OtdEU/OwrLSE7WTl?=
 =?us-ascii?Q?toH9ne4s7ja4q9utrxt7ZPxdmsZlkFUYqqbeMU7MrAXT3s+Je3ySYod3eHgC?=
 =?us-ascii?Q?eAU6i+1+33I8Fazn5/Cz+rKmB6qdWiBlboppgWaSha/QFQOqqei7KY55D9XV?=
 =?us-ascii?Q?TPdFzgAl0+nkwpKRV64SWvMqoqTtb9Q1PRCqhSyExLP2bzSMGGVKY/0gopxu?=
 =?us-ascii?Q?32AAPeCOH8FT6JiC0aNfMZXoIfEHTp0gc5+TMaKlSxMuDQaIDa3pQHweo1wC?=
 =?us-ascii?Q?YP4r0tQ1w2cP/H0CB89Zlnb2T7GXnE1sC6ubuThBjJnchgM9it2H13j+JI1v?=
 =?us-ascii?Q?BiVJSAQhsmnlXPEal6o7S+XcrJe29Rc9KWahxO/SDpVM9I+wSlejfHxL1MJN?=
 =?us-ascii?Q?SaFkVHa3VFRi21Ujlri8vNvcrMi0lZ5wNx/p8j1Q6qQqlDjKZohYlUMqKhqy?=
 =?us-ascii?Q?14UZZqbfQpt0xX4PVrrDGid9rWJqZf8+xX+BMLQwzzHlhDK/n5Gs836KlbE5?=
 =?us-ascii?Q?qPTjxXUjp3M3l/5Sr6r2wTRt/aQfIpToNnkHsxI15TJ3Z8/CWyFGXcBGBwDh?=
 =?us-ascii?Q?mkuvm8l+8clGWu/Rqo1udC5VMQAeu1k2lHb+PahXnd1F1OdAzRr+/YPh0BAn?=
 =?us-ascii?Q?pyH8LyiAwWUZXShZwhbgxW2X6Kj28bOIWbKaIikS96/WS7DmDO4UnAJ0E388?=
 =?us-ascii?Q?XG8MNdrTMvWFW6cXFvAkMnPyMjU38N63lB+ba4xfvGMnz3ZgQT2cXBG3D6uM?=
 =?us-ascii?Q?sR0WJHm4H3WY+Nf4AXz7OwEywpaoo26y+tK5UGGI6dfb/QVAGEJgWspBbVHg?=
 =?us-ascii?Q?/hhJaLdtHO2F6PVO9/0OXG3luc5Srr+znUbyY+RU3VtJ6YSIQ+EmsT+OBrmY?=
 =?us-ascii?Q?vkwjQczVEnrSloRoEc6iWRYo9NZjtL5kWK+lZ/CmGzC27wyk5WdXsjNYtaaR?=
 =?us-ascii?Q?lF81JijCOA9goumg5nZaSf0xTbmsj1sH/udQ/OiKlbVPLnHuiNQnmb8rzv8U?=
 =?us-ascii?Q?X3qqeSO+uGzKKBTuGz37vNWGC0mJT4UQSOQCJ2dyDnu+UwLof0tElbiP7VNR?=
 =?us-ascii?Q?Wxy0IjBY8NOj+BLUyt4GAzkEELPoWVMw/9f2+cyIuNOaAfcHkJt6AgLZRWWU?=
 =?us-ascii?Q?5/bJAV239+llTNPToIPaAoUOvk3HaoIB/IMM0BC18PIy+wxozsX6UscG93/C?=
 =?us-ascii?Q?Ysv9qwWiGaAfKMsmqrVen16UgNu49Km1l3mHr5AeJdvb32HGS5dd7cR+EO3N?=
 =?us-ascii?Q?zv8Jh256SXRipnaNfNjfD7qiPyXW4Q+uBeTzVAWQ8l8u1CMD4Yj2b0orfk5s?=
 =?us-ascii?Q?5/mMfBbtL9hzxjWq9lwdjod/6h/fKYsQ9L49pR89BywPbYgKEHlWezjCV9wO?=
 =?us-ascii?Q?RetZTV0LTmh0zm3CqQJBeKIL2w4yWmk3YMPSKRdToyfIQBRMFnSdnfgjyz4z?=
 =?us-ascii?Q?rA/ptrhmfHg0zCNXyM10f2Z7dTVpHQt9g6Hd8qFFa9CdSVRQSlNtAsMPgUdw?=
 =?us-ascii?Q?62jYKyeGWM1drY0sBg0xMlGUc+VO1m5oBB5VRAfXCyRYEEszYBjXtzFmsC7I?=
 =?us-ascii?Q?P/UfWWu5/xz4Lq926Ro=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e81e1bf9-f85f-4169-eb0e-08db47ed702b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2023 13:35:31.7583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: khnam+FXpRtP3KUZ8tmTPq0pyqJCjuWy/JzDupNi8GPbxrygzVC80WMjyFe/AApEMOaGzkAyLJTF/KoVmVZTog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4097
Subject: [virtio-dev] RE: [PATCH v3 0/2] transport-pci: msix register desc improve



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Friday, April 28, 2023 12:47 AM

> > > > [1] https://github.com/oasis-tcs/virtio-spec/issues/169
> > >
> > > Can you please raise the ballot for this?
> >
> > ok if you put in link to lore, not to oasis archive, then please also
> > include date and subject so people can still locate it in the oasis
> > archive if they need to.
>=20
> Also please link to virtio-comment archive. virtio-dev is for device/driv=
er
> developers not for comments.

Added OASIS virtio comment link.
Updated lore link to virtio-comment as well.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

