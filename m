Return-Path: <virtio-dev-return-13474-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D42D4C001DB
	for <virtio-dev@archiver.kernel.org>; Fri,  4 Aug 2023 14:12:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 407241922F0
	for <virtio-dev@archiver.kernel.org>; Fri,  4 Aug 2023 14:12:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 38C6798685E
	for <virtio-dev@archiver.kernel.org>; Fri,  4 Aug 2023 14:12:50 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2CAD39866DE; Fri,  4 Aug 2023 14:12:50 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 145A99866DF;
	Fri,  4 Aug 2023 14:12:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+Z0RHALzUhn35ALOw6AiO4RDklKv3VzznM9TjiTdQGaGjtHDt0e9QFW0ZyBGPk3OME6Du6vaKyNEw25YsD1qypUIamM+zIVrLY/szhaJaVDhjbWPp+XSGV9jMCLleWCvZyAJR9ax3j++rg4gzwXA84RhSOO12gZLq8412uqaGovTH42wMeXIth4QpaV+VVE0CxTnUPaTC6Xqtp6gT7JF04h2V9M2Qrqs+h82OJBqG0fhwvyvqfnnZNSVU4DxZSN0gHETSoRAYwIRfO7SJUSlDNifLRp2rb2ie80aeltifiXs1GELraMTpoKzEARZlTbG4w3ch+GOpduU/38kOVp9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HjbhwC0X5YxaL/iZ5fNq4sUxXM2Q0lGOOOyn99bFG7U=;
 b=SNfO59TrbU4Jfp1nOyjgEDzYTvKN+u4HqTRKEEMPlg9Ifs/bG5w8MrFQMilcfGcHqNRuRq+zi8uCz+VhjFglJ6gUjjL1q2YKNR/MT25+hy60C+EluzBgg1rRQfZwPZEzfUsdp8QJmMHW4FJLxbYqvTauGQDHhBykgISttZMFfle77fDjCZ4W4dr4iUENXbKtJ5+u6ekBNa/Pb92j99cOkaA15ZHMwi0dmGLkcGfoFvR+OPMHTSKBbGOmCHhpeDiWPo0aCg/sumjpze99GdedkhHskXkEhoJt08alOxqLfxX+N3HfynVXG3toBOgUzdte3tUlzie4/rtHP4UEpMPMbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>
Thread-Topic: RE: RE: RE: [virtio-comment] RE: RE: RE: RE: [RFC] virtio-net:
 support access and control the member devices
Thread-Index:
 AQHZxeT2Q5D2+syVdECqHrje6hzlHq/YUmCAgAAS74CAAAGPkIAAAc8AgAACoHCAAAFdAIAAAN7QgAACXwCAAAH+cIAAASWAgAAY2vCAAR9QAIAAAoAAgAAHcYCAAAfd0IAABlWAgAAvCwCAACGFIIAAGj2AgAAAzdA=
Date: Fri, 4 Aug 2023 14:12:41 +0000
Message-ID:
 <PH0PR12MB5481151EFF6442A93BEFA3F1DC09A@PH0PR12MB5481.namprd12.prod.outlook.com>
References:
 <PH0PR12MB5481E104793F9E68E1DC95CADC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691062877.0013635-8-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481C3CE21016385BF7D6FF0DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691129914.3255427-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481F521F146049E5E483B7DDC09A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691132049.7182267-2-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481BE16AC810CD3A6D64832DC09A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691135097.4908528-3-xuanzhuo@linux.alibaba.com>
 <20230804053958-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548152A5677F0508A62587AFDC09A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230804095255-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230804095255-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH8PR12MB6985:EE_
x-ms-office365-filtering-correlation-id: d3c60408-728c-4c09-7b89-08db94f4ddf6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 O1KRm/lSbo8rxxjURDd5UY01YdW2QVw0Kk312NhdiBizybhj1fmM8nNwW6pVpXdHgBKTMV85NlTRZUYLnJITSQ6/00hUsk1+NguZkQaejk5eh2GW3sKfsmSztY8kq7bm3aXJarJhs3MMlR3cnm+h/s584iCnmnJFrXTiZyTxgcUygYY3ATHYMDCbxc5r9pG8MyxbsJBFCFKwkW75ZqZxSfq4WEB17iRg3HPMHl9IvodnXaG39vtW2OaBM57DgJ5S9FL5MuqmJzEMMAo7w71+zLvrhzoHzC3of2+GmL3a5eltnFa58tZciTseB/+7Y/5omCWDIbXsQVgLt026kwGMdpZZvwgwt3RJo3a+slpybGDFyZwf2QjJUVhicPvVSUOc6XprlQpdpQLB1zei3ozjbAFg94vbRJl6sk7s5BlsRwTtpQrKi9kDyow0bXdXfHEIspY3IlE6I/7iR85VlPAbtUIs1NjSpedB04SNplJtNgKM5eAGcFIsAH4/+6k3Y1WVeMfn/sHlvPwUpKq5g6TKliBczqxJGqO/VpUR9UnAp7MyfN1YBhK9HIS/aWoZNdFILpS1NfXrmdx3lrTLWyi/2ZkfgyWWhs4UfDNGSY1cbYLw0Tx7Ipw4dszaSqa39Dun
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(366004)(396003)(136003)(376002)(451199021)(1800799003)(186006)(41300700001)(8936002)(8676002)(83380400001)(6506007)(86362001)(26005)(38100700002)(122000001)(38070700005)(316002)(478600001)(66446008)(7696005)(9686003)(54906003)(6916009)(71200400001)(33656002)(4326008)(64756008)(55016003)(76116006)(2906002)(66476007)(5660300002)(66946007)(66556008)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?iZIKZOMn7hF/jxeOpYVWp0VPckiJvVMEIgC3sHbPBLAIp7p2vAVNNKNuRSrC?=
 =?us-ascii?Q?vxxWfgzyauyjubVURNlVFDJL/9X59otpA2I9OTd7Qx69jWbSVExZXGdt88rL?=
 =?us-ascii?Q?X2KgvUPIQSNQLYt+ssx6/Rw9vICC/LO/u10hepLp1TVTY/fpXRuoeH4dLy70?=
 =?us-ascii?Q?vf05daezsHVLgk6ylC3Jbn8twaBuVlH3a3ExXfh+4Fqf/xgiqVN9bibSjrAE?=
 =?us-ascii?Q?0MQ7ctWRA6StR2tOVBx0e2a7q2MNcMPGhXt0fECKxd8VFFEW47c4MS5daBgA?=
 =?us-ascii?Q?NmA+39n165PqXLwuIMYEowKX9xwgdAJ75xLWf7yWP8YBNwmkFfDQVGAoDVBu?=
 =?us-ascii?Q?oTb9axUs/A8aQZh0LPt1IIjI/XsKpftosSF19ags3gP1oRCtJifiy2/sxmwF?=
 =?us-ascii?Q?mWy2FiTYHEHMoVP4BbrXns5NlTgewFbOmEYn1KVVIjI0+1GFu0UncEM4M5fw?=
 =?us-ascii?Q?STjqvS1ndkN9dJ3FFzjPiadXgbaoVWAkCb64u6MIIewFafT7piYCKw8uljL7?=
 =?us-ascii?Q?v6zMIcuVY6BVGDrbXWwYb1Yaz6bqsbsFL4nDu4RQSfemnY3ct1oyYP0+3n2b?=
 =?us-ascii?Q?6u7iyugewJjn288yqNeDWvkN60LVIguW0CPeZeT1rQHCorhI6V2R+BKuq5jO?=
 =?us-ascii?Q?ktEQd1mZIzwux3hEfEakv98kz6TKjTRIAW6ouaazdFAstbfUdbx3Dd7dspuc?=
 =?us-ascii?Q?McFx7IzJsVAnnwxzDJYs0raVHCdD6uoeUIStr13i+FIhaVj8FxhasTIEMc3R?=
 =?us-ascii?Q?74akZrUiVBJ1nBhh0aExqjx+X/eUkvkn9j11M1+lT66OMM5oqJFwQZt6DFnO?=
 =?us-ascii?Q?MLAqVQiDTVAtuAcxdY+hCDn6M1BEus7Ve740YvtgUmdRRMQMfkR4c9m9ShRK?=
 =?us-ascii?Q?pwmRh480hKbRFzOob8IHmWlp6kTAhzlJc+AilMEobRvq4JKJL3J8bFbrap7W?=
 =?us-ascii?Q?ruFWbSeLTWjI1Nxcuj+M6CK1BEX1yCZRuzeAtYayrbRaQRxheNa3XnuR2asq?=
 =?us-ascii?Q?buIil/oOmssR2wuIC7DyfGjRTuz89hdYgWsevNLXXD17fRvbz6ork4rBDit7?=
 =?us-ascii?Q?zxkQ2iNQYffBrGGcKK4QwbbDVnRPN5Wp/n+/W3GEovNyCCB+2XShBQ0cwO0B?=
 =?us-ascii?Q?hqted3Nxo18H3viCcvvmCBs0b2iIBhouZdrNGNnaAsCYa8YVqoUAcvuh1p+K?=
 =?us-ascii?Q?33wyLpWZk7SrwQvbg0WP5eraOtgf5Goz6vL/bE2ku9BQ5fgq9AkNyVhFzWKl?=
 =?us-ascii?Q?1TNn59WoEGwcyaAGwcZ4wsHuIVwYjtIFbA8Jwl2TpTZMwOOwToc+/jtU7xgd?=
 =?us-ascii?Q?M4urR0oT312rDPGFnWvaXHEIMI5wYxCJxAADnOnQWr9OVzqPezQzJ1tkPklM?=
 =?us-ascii?Q?XUA4RXJQC1g9z7xu16/SRl+IFlxDdDzx91fgwSZO3Lw0PdmRPLRY50ALiP5g?=
 =?us-ascii?Q?lMbWRb3DAfnA0q4qMe4et4ZgO6M3DbZ7weridHJX5U4ZrM2NLpY1kMqlwQpq?=
 =?us-ascii?Q?b6v9dm11UWbRYA08K6TD/YmKBsargJvQgI/7SXxH66RnmntSRqbcVpMIHCCe?=
 =?us-ascii?Q?5IZZIbsehIQk584NVL0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3c60408-728c-4c09-7b89-08db94f4ddf6
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2023 14:12:41.9660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VXVOMvVR4OSk8HBrG/GSDzwC7sPaV1GrZcC50A7JTuykFgVu97A/NcPUWHuGX8O2Z2rAKcZui464rw6i7vPK4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6985
Subject: [virtio-dev] RE: RE: RE: RE: [virtio-comment] RE: RE: RE: RE: [RFC] virtio-net:
 support access and control the member devices


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Friday, August 4, 2023 7:37 PM

> > True, for us, at this point we do not have plan to expose virtio switch=
 device
> because users are not blocked on it.
>=20
> If someone does though I see no reason not to - we have a variety of devi=
ces,
> switch would be just another one. The motivation would be the usual one f=
or
> virtio - so there's one generic driver.
>
Sure.
=20
> > > Re:queues - it's not by chance that we have multiple admin queues.
> > > So driver can dedicate one queue to filtering commands if that's
> > > felt to be important.
> > >
> > Admin queue currently do not send non admin command of the device.
> > Would you propose admin queue for something else also for rtc or consol=
e or
> cryto device and indicate its role so device can understand what is comin=
g to it.
>=20
> Well, I guess this switch has group members as its "ports" so maybe that =
makes
> it like an admin command. Again it's all up in the air too much to be abl=
e to
> judge.

Flowvq is needed for non switch device too.
It has advanced to design stage now, its sad that you are no following it.
Anyways, flow operations is not a admin command.
I don't find admin queue suitable for self unless we modify its definitions=
 a lot.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

