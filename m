Return-Path: <virtio-dev-return-12967-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA9AEB64DB
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 16:39:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id F0EBB2A8E2
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 16:39:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E9B059865A6
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 16:39:23 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id DC6DD98653D; Mon, 19 Jun 2023 16:39:23 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CA3BB9863A9;
	Mon, 19 Jun 2023 16:39:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lGp+64MnwsS5OvhUXWnf1BqKHfkByxfil0EOXoiDOvGFlMolHFLvfsiJBhxHTZQ33Y9sjoJ9mYnbrNhuIYlfWEevYR/GJND2mYiJCCWdbptvj65uCdg1Y/nkEJn0Bq49oPyqQyGUXQJffdhPdtvlmbsXZJjOuA8XM5XVRK/v/cmF2k05cQYgRJxWwLg+Q39oAym+KTspa+F0WeDWxGqnC8Mz+rAneLxkZt2H0tFyf6ONEYwmvNDsAKNXQatcc/gjgr9cL53kr72WLf7TDbelmjBJ0SSzEA8ER5aJFH5fmRZLwwY3pdtSPBCNYqM3To35W6Ae0W56K7WrOLo+iGrhpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jl9+CnJFSAnZv8wBIr/FkmbAgkgnf8EesZrUXo0N4HI=;
 b=aW3QVG6t3pUWZ6BOSFFVHLsxrmJxHml85BjJ5KNyeehgX7Sxki9aDOrE2cinGJcfSRmaxpwaiNUquWaddmC36E3GGD0qi1kCkvEfJ3BilTCVqEe24IulQwPziIuSW00rTX0zw6E+LkoeRCkQPCHSzEeT1gjcD5gbyfasWEVa5lVGQCYsXQUo8hjZaF6S67cs2dq4Sz21JEVtCG997Q9Tfj71zFDKbhWDKscdSYQIrUvExyVJH41awzAeQuqMu04+uEyqLNQ6O8d6je27T7Q4E7Gvq6CB1NU+BZC0eeNNGacN08LufUhGpPwREPS29Qch/9Trrx4RkhIQ3/sDMZf7ew==
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
Thread-Index: AQHZnhzOtKzAnSMZqEmlUO1lSJmuDq+SXH+AgAAALsA=
Date: Mon, 19 Jun 2023 16:39:16 +0000
Message-ID:
 <PH0PR12MB5481758B8EE080750D6377C0DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230613173015.1244486-1-parav@nvidia.com>
 <20230613173015.1244486-5-parav@nvidia.com>
 <20230619122836-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230619122836-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH7PR12MB7115:EE_
x-ms-office365-filtering-correlation-id: f13ff2cd-692e-402c-a641-08db70e3b908
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 JLCnLOXy52sDDXJu9vBQBedRmgw8j+ErVEUMwXP6jgnB/MCtKFv3eZ3RL19nlW+ulrghlqpe49/N85HT/hVgp5pOWm3z65g8OVIsU0QtD4ggEnRBv6Kh/GTYK3RgjESl9ff4TWJRpW3vf/by22MHglB5qsZkTjEFsdNPniNCKp87gQ4dbKAvzUkRRmm9xqV4M8iUGYv1Cl8B2w/Q0j2ZZasVNPfS3JSY6JqyYJWgpVnSL6zzgMHavX6MrEpjq/zmFsguIiXFA1FPnjL1xMsEplZMLd4NEbjIZQZeEkeCgIcE7mfG7m7SzNZ5EZuG9WBD7OkGLBsWbvzlQbAxf0mk9GHYrMSPZ4sExgtVIVS03v8euVrJ7WOhfrsR/4sBPXOVPJW+laOIKDWOGQAnmowR7ynd5blQHb96Mr5YB+E9LHu+eJtH/tQNxwkTME8sZgsloKiv8eCJi9BAxbUvcsf2NHG065/yHvkRrEj7qoW6a506ecdYjj/Nt5ZTtDGBtrEHkEVMLqCMHocAcDwE3Z23Tfq0T0vdyFq8y0gq7khCqSLzILYUOFo1Levmpx9gRkGr7ee4+AovA9yvPq0jHcjSENEuZd6H6N9f3dFfpK/2+0zMLJy+JXXC3R8z8q3qSC0H
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(39850400004)(376002)(136003)(451199021)(66946007)(8936002)(8676002)(66556008)(64756008)(76116006)(66446008)(66476007)(107886003)(38070700005)(26005)(186003)(6506007)(9686003)(83380400001)(41300700001)(38100700002)(5660300002)(6916009)(4326008)(316002)(52536014)(54906003)(7696005)(55016003)(478600001)(2906002)(4744005)(33656002)(122000001)(71200400001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?enOD/SMdRtdwAwueAqm7m2NKuUiayGSsWN9A9P1iBDLy4EBg1AT369g4xtpu?=
 =?us-ascii?Q?jcQB20usj7Bd9ejkkAIKQ/W6VQX7Z/PGv6O1EcEqK3avxxWB8uF613A9vl2Y?=
 =?us-ascii?Q?3QiTUx9hK4IYsH5c1VDG1Ga33/HG+vAAiskxZoK7S1PA5EjK+oONiDNTZ42Z?=
 =?us-ascii?Q?DsUYf0Vgn3JvD9x9waAxIit2I9qVIApilpNFy2W5mUGKh+BT2MPFRSk6+4zM?=
 =?us-ascii?Q?e6m4T7oz0IwRe4+if6YBT047CkuuXXfHTX5Sh6vfJCuvjN7NAqoNG0mWrL22?=
 =?us-ascii?Q?ZTyJqxXy+6pMHsEE5qGPCHqj8c+0TjQuHOyWEZ+xdvyQPTy/YYy9fT3NkdC4?=
 =?us-ascii?Q?egXLySe/9KuBFXXWVf3kZibLCUIEwwFFmPg9l0BQgsqmmfhLg1hagROkocOX?=
 =?us-ascii?Q?fSNtpb92uAnoqqZztZYcXlnJj26mUPKFB+3ibmR5iZStBOevsZQLvUpjGTj0?=
 =?us-ascii?Q?/wVs8nWm++q6hju4GkyYjKSwjM/n8/EzSZ1Mczp1llSrH4cC5Q1CI4gODEYp?=
 =?us-ascii?Q?YGhhYgY8+hinS2UeOKyJACicuYq1dfUObSyvmcH8BpieR3YEtYwQl8pvHaeA?=
 =?us-ascii?Q?GwWztSM/PxWRB2vIzY/XzwPrTe5yY2l0lI6GyyOOeVTG2Ma9SLBqxJqfRnKg?=
 =?us-ascii?Q?kbd9Eq4JcLGvUHHTUJLkJ8C/HqdHf7BAXwPpHXbLPmThO0lSO6GjN+hYRMw2?=
 =?us-ascii?Q?L9bzPYRRJ2mYdqa8oYUbpWD88yJa0MuJaC7lSzGoj+UW4KkJHeB21hoiv+MW?=
 =?us-ascii?Q?IBu7Ib0fo4gbsWHUXKBjm7OcoxnTcIKgOHf3mRbizf2ypDEJ2CiuTYxrv4ZJ?=
 =?us-ascii?Q?f1Cv60NKVVrnpqWJ6d92FVT/TdaEr8sk3ws4fRkugtUyd73FoaHy6vN1lz+O?=
 =?us-ascii?Q?pFOSli0Txg0Lfg4qx9fAX9iIlwdfHO5oLzJKZ7ZI38CwchouheqL0QIgYjHe?=
 =?us-ascii?Q?QjWCLUrUflGah5pA+6dFgG9aFq1TM6EKJwrnevbznqfIjpNiJ8vbt+Y+jrO2?=
 =?us-ascii?Q?Pjd+1n4IJ3w7+SrRV/f/9ma78fTgmCOu6j0S3KkIrx//Sy/2rCLSky6eEH/+?=
 =?us-ascii?Q?h0C6G4Ri3rtgHmOSIHKpK20VbqNMM/nWxXQ65HUqUMsV+Wv6cE+gSUYvQBkn?=
 =?us-ascii?Q?TXMQmSRK9b3p2bw+M+URhWictM3ESUhrYkn8QnkoetjoMi1zRzH3TbRHMRiF?=
 =?us-ascii?Q?UyhHXLiYLzg3MatY8HWzmQiPgzKU4rxCoF4ySELurXxFEfj2V9TiqKI+h7is?=
 =?us-ascii?Q?OMk7NKWBh9pRpt/aBmTjWY6bRDffnOwHyF9BsLUFuU0HajgdFiZTdaHhz7KQ?=
 =?us-ascii?Q?JQtm1177vV9AV3GDNal4bkOU+uY3RinamEpm+pIpGRFHQFxkIsiOZepUuqCM?=
 =?us-ascii?Q?HaySWljvm8U78DGNGUHiX63wOhA1ysDiTO7JQWPPcCqhWCjUerVoVY5zYMqo?=
 =?us-ascii?Q?2Ncns5l5orYT3KzS9XBIQPnUr7od6DOpKRdLcm5+AXSYPL1Jph5TYiMMpzj0?=
 =?us-ascii?Q?grXFbrmwJBb29E6sMo1PUHGHmbhwhrSrDay20IPXyFx7HzmcKyp8XLNIcRfJ?=
 =?us-ascii?Q?D3SPeXFA773epK/hviw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f13ff2cd-692e-402c-a641-08db70e3b908
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2023 16:39:16.6679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NiTQKDb8cyXmW82s774i/5vLBLpcp+IN5Rpakw0O6jx5G3uAKmaQCYnwt6s2ZN4/x8L9Ws+h+rkCvs1x3u+gmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7115
Subject: [virtio-dev] RE: [PATCH v6 4/4] transport-pci: Introduce group legacy group member
 config region access



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Monday, June 19, 2023 12:38 PM

> >
> > +\field{legacy_q_notify_supported} when set to 1, indicates that the
> > +device supports legacy queue notifications at this notification
> > +location. Legacy Queue Notification address is derived within a BAR fo=
r a
> virtqueue:
> > +
> > +\begin{lstlisting}
> > +        cap.offset
> > +\end{lstlisting}
> > +
> >  \devicenormative{\paragraph}{Notification capability}{Virtio
> > Transport Options / Virtio Over PCI Bus / PCI Device Layout / Notificat=
ion
> capability}  The device MUST present at least one notification capability=
.
> >
>=20
> I was hoping that we can avoid touching transport-pci.tex completely, thi=
s is
> why I wanted to reuse VIRTIO_PCI_CAP_NOTIFY_CFG.

It is reused, but it doesnt come for free.
Do you want to re-consider AQ notify query command?
Or continue as proposed in v6?

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

