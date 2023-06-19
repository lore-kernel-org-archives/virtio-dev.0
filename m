Return-Path: <virtio-dev-return-12986-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E1EFEB64DA
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 18:12:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id CFBA323D58
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 18:12:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C47229865B6
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 18:12:19 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B814F9863E1; Mon, 19 Jun 2023 18:12:19 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A2ADE9863A9;
	Mon, 19 Jun 2023 18:12:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MGt2cArP9TNuJCBJXcq+eknkcY1/QrEqsTkmi1AeYP1HHrV+eDEGqJvVqES28Sa9j1j6wDS6In9fgmxVAAKB8f0y5GOSHfdGixAXngzGr1/a7IVN6l6szXbHojSHFBvdA/fNjmZCjaaZrwG5AaVDuw1FwnkUDi4cfrnmo9cB1TThHBjmhH5+nL3mQshKduDylgIG2zmYWiEZqiwGZ1mGeJY8JDtCYE7rJyL0D2BhRy+FsYPVDrtSMVXqcZn6/WU0zPix3+xri2gYgFO52qNEy1eX6mMcNpUs3tW815lVV5L4mvO1hWlLolJTlmrelyX5/pxVRBDZ/Xt02lr6t+bkUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJWW3iPXwaGjAATZaNp8GqYDQjhNoIKhYtnZj1Zk16E=;
 b=jhj13fInw/mjZCjeLulr/vgWsWlBaDu07HPIwUJ9x31JpJo3/Z3CihFrHOAd0W6mljg2NTRN79ojlNYgb5KuC8uHtXgGA1hot0O7wqQH/HTBzx9mrwSV3xjraG6xHF1q2x5JCbNgAncTkohvid2SuRSv9d7juzkgOl8ZF79LTommDUo9b8jAIaP9FRUWoFbD2ocTuxiFPKavp070Nr44GLGDE3/yVP558qVqTrlhemMDVCC3q5jMYN+3nWqSclkUfhKRUbSKG+6YWmMqalA9kIZ6TbwpW28a3vUCzz0cANDTsunJAxLjrEPTVaBl05yDjKVc6EmsO6wg26Ibs8B0gQ==
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
Thread-Topic: [PATCH v6 4/4] transport-pci: Introduce group legacy group
 member config region access
Thread-Index:
 AQHZnhzOtKzAnSMZqEmlUO1lSJmuDq+SXH+AgAAALsCAAAuagIAAARvwgAAD4ICAAAFGkIAABSWAgAAB40A=
Date: Mon, 19 Jun 2023 18:12:11 +0000
Message-ID:
 <PH0PR12MB54818E61FF6F0B15768829AEDC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230613173015.1244486-1-parav@nvidia.com>
 <20230613173015.1244486-5-parav@nvidia.com>
 <20230619122836-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481758B8EE080750D6377C0DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230619131115-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D1836A5B9A7B345A20A8DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230619133322-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481E624E00FC403C9ECFA03DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230619135750-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230619135750-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH0PR12MB7790:EE_
x-ms-office365-filtering-correlation-id: ff35def2-f8b2-42bb-52ba-08db70f0b41f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Eigju4y59q2z7znUuztK9VDG56ROmkkBY5z4tBzb9QSwZTndakciyras3EceD+ftWXrSOL0Jxc5HRHhWaYmeqxWGp/MqCbP0EpHjWsvvvJ6t6H/yjEpqZZx7KcGPsg/IthdebUJj7Ryclc8UgLGIeaygF9QgUp1Teo37MVOxB4FpaDoDONw6dJ294OHfwrnEO0QWqWzw24eTtIxD2n5izyyptTae1068dzjHGG6hubVGcZN6pNnhv0FR8pu0AvGr9bvt7SLAMUrVFHeGJfnTVV/Q0cpCSv/bdqIDXhYrhQWd1FOsjO2AMUuUW0hz73SsuYRv8O5SxRah151vmoi9bNK0LFkXqZ2rsqoETB3WdUjPCIkTp8U45nF7kBUEHnf6leI1jhGlk+Tel8GEZ9KC0X8kWsT7udnCdqsowrE5X8lx6uSe9nO+iPR/6iIWIAsQC+uNykHaAgywHRn4yUIrLro5NcbBAopefJzI4SHYDGUzMGIX9Tu4EgokrsQWf9uyVBNZIEPNWe0yKmSB3mnskxD9WvsmkkVsQfGMHjou60g3dcO+96V2vetMpQobDKL38yEm4ERw6EJLPEPkPVgCoIBtqp9PcHbjNdAjmvWxiBm4ihlimQUeVENogpAmsfro
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(451199021)(107886003)(52536014)(86362001)(83380400001)(2906002)(38070700005)(122000001)(76116006)(5660300002)(4326008)(54906003)(66946007)(66556008)(8676002)(186003)(8936002)(66446008)(66476007)(64756008)(26005)(38100700002)(41300700001)(478600001)(6916009)(55016003)(6506007)(9686003)(7696005)(71200400001)(316002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?iIwvGa59ud6qrn132LmEGgxovkB1b44Hcpy/f5Il3d+Tu0ZfWDGwh09mDdu/?=
 =?us-ascii?Q?KxvCbDmhYh+XKshTWamkhubrRZx1gTDCQlxfqM4crAGx9aS+ZXX8p/+21kT8?=
 =?us-ascii?Q?kyVRve2jBGJ8zQEHUj9/SGqm99uAZXdG9otTpbHznFkpHZWhRhmr561Lncbh?=
 =?us-ascii?Q?8Ee1pe3BDR6Qntrbi6EATo+douDrp4MLW050yv0Qo0++ajdrxkTh7uNa4F+z?=
 =?us-ascii?Q?Bpir59UVoZgfoBNHuq2yXykI5aficIPDhUzrDplwf6lJcgALxiFwryYAk0rl?=
 =?us-ascii?Q?119qtTRS2rJp2UviIhH76QsyZfxl9Nyq8cAFPwMUHIFLdyJjcdtFEBVw36xF?=
 =?us-ascii?Q?JSdU5LMmAWTilc0Ty/IicXvfV+Ny90a5jSyajMHxzXQnH2JC+V3odzi+WKHD?=
 =?us-ascii?Q?EN/FwkHlQGRJbvYHK4bXktr0W5b2mgOF4osPAB0G6I0WbE4OB/zX+nZ++Xdc?=
 =?us-ascii?Q?ZN9YEHhmlQNKCuVd592mq+mH68sHL6v/QYlRuKiZ8QJpq1x98DXxRPiTAUKN?=
 =?us-ascii?Q?9RNQBcbIiFLTZeCjtcpXXpHqrCklrrxJwkop6fH3JYkNhKX8iOEd6Ig/6MRa?=
 =?us-ascii?Q?oBTyvMtmP60vpTvVlT8cj+kuhmSBhQMkKL4Mc73/UxrPWst2h2Rfn5xXQUdx?=
 =?us-ascii?Q?xKwDZQTxGvRxnkZM297d5oDh5a0uDifabumQXZYJ8aW/11ICvIO3HpYPewDX?=
 =?us-ascii?Q?qM7jwl5Fp4DU9XK22widvzGkTan232vBE/II3x7yY/0AHN3wLW2lrsljcHG4?=
 =?us-ascii?Q?Hz8BZIi3PZ2x4CPdHi/v+UjGZCoUNWH51E3pcSacmPAzdEXJ1slPL1qoTbN/?=
 =?us-ascii?Q?dprAkY0Bg/p0zZ8Xfm8QrzTFro6FSCFAKDgYYKSAUnPIuJhz05fCyTT3vSMU?=
 =?us-ascii?Q?0s4opnsjHGAx9M0mvdRaevijq6cY/0q1mJiWgVXdX8PNZ1opUBCAPmkF/kEQ?=
 =?us-ascii?Q?ws58VEnspukNHoli+NMJu30S/5rFC/WFuQvmZ1Kxp7RC75XSXt87v0fYrlCY?=
 =?us-ascii?Q?YZJzj+HlAF1pmFt2aMCpOxlOMo3qvG38uA29mliRW4QBTnRXf59bCr1LXG8X?=
 =?us-ascii?Q?7jvpD0Lbiu4vukJiiveRJ4PTQ3lE4FHJuK/NNdK/AuLZ/M0VBXVzgyYkbwL0?=
 =?us-ascii?Q?R9jbd7qdOlQRebgWe5kLK2f9E5Q9ULJjgnDSKz8brxjnV8cZ/9AzxyOi8i7l?=
 =?us-ascii?Q?/eune/QbX7iPnwLlEVxuoa7ymZlgiPWkAt7lZUzUvIUwgS+Z7tiVW6jz1wPi?=
 =?us-ascii?Q?PZKJ+Nls3SINdlxzInihJM4eTM6/+rqBN66FzIXZJ1Oo1eAMqyvuRU9nTt65?=
 =?us-ascii?Q?DR4FsKaggbN1oV8/RiM3p0ZyA4QjU8A4WXyKCGU+0WJI9Rl+hjPSUwp34hFk?=
 =?us-ascii?Q?kE7bkrrcbt2xgkLI0lUZiZ9qJoHvYCZYcH1YLT/eMs/Yl5eyZhdtUfXUb5z9?=
 =?us-ascii?Q?n2OvfR7Oz2FjctPza8AjxLn1u9BErf9NEq5Y8g9Nho5ckSJOB+rXlRnJssa0?=
 =?us-ascii?Q?HSLCrSR3m0xOqBD+q7+bARJwGLEp/F/3NeEF6oJTA8whE513YOolSi5n32SU?=
 =?us-ascii?Q?wS22Q3emXXZDF+Fh8Mc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff35def2-f8b2-42bb-52ba-08db70f0b41f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2023 18:12:11.8702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OHYeiCZIG46OIz2OQZncR/PHDTeNA5sUrJy39XqK60YEfO3RrMN7zkc7nQw4qISNsaVgXWpJKaxVzx4UmabSXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7790
Subject: [virtio-dev] RE: [PATCH v6 4/4] transport-pci: Introduce group legacy group member
 config region access


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Monday, June 19, 2023 2:01 PM

> > That flexibility is better gained via AQ instead of introducing new ext=
ended
> capability on the VF.
>=20
> To be frank for e.g. transport vq we'll need to do it with admin command =
(can
> we stop saying AQ please? it's a habit that carries over when you write s=
pec
> later. I know AC is a weird abbreviation though
> ;) )
>=20

Yes, this was mentioned already, but you ignored or missed in past, not sur=
e why.

Yes, admin command.

And yes lets please stop calling the transport vq as well, as it is not goi=
ng to "transport everything".
It is also just bunch of commands... this was discussed in a thread with Ja=
son and want to park that discussion at later point.

> So yes, if we can find a way to make everyone happy with admin commands
> then it is better, for sure.

From device side we are ok with Admin command to query the notification off=
set in the VF BAR.
So far you had the concern with admin command for query.

Let me know how you want to proceed as we have both the options proposed no=
w.
So in v7 I want to write the final option that you don't need to re-think o=
n.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

