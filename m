Return-Path: <virtio-dev-return-12687-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 999D2C77B75
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 15:10:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E69C97A8C8
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 15:10:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E13249866FC
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 15:10:22 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D526998650F; Mon, 15 May 2023 15:10:22 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C4590986510;
	Mon, 15 May 2023 15:10:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AC3GYks4JwKP1b6m14QH20wvh0EFmVF43x2JYcXyt+cEvRnSnM0/XAaeeVhTGWciQk8NcFxPPoezCAOGC8kkY0HHi2NR6Ou2HhOZQCsiqAcQCREun2fHWvSBjr45+2gK78AAhJQIK0pultLxOJdE3gSu/hEIRoPVzxLWSf0Tl2HhxpUwk29oPwulGq9D5OgepOwA0qfRGVtvzOXrjEzPx/txtLEbHfcCyyu/Mx5ggO12xTHgxawx1PMZ2UFHcTBMy2UykjZL93rmX/0h3Z1+AIw4wtNeNkhQvltHTWVUoju3KVqgoyzPGeM02hMQ93Ng+bBJyGao9hrTqxb83oYfWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NA19gawOlmKthQybZU0ilohYWM81zLS1GdCNwLacDYo=;
 b=kfulI8n4HT826h4AZMD790clS4+O0xWr/nBdUYEjp51wHdklmQ00lou0xvN4gIVIgzl1ykQZV8cOP0PWYmH1beAypWIfUNp6QDAodPl1gtvWRLsG/YQavhUStoUm3o/YqMPLN0XEiLAnqPANE/BNAIWlbzpR6cyGORvvQfeH3AN8IdsHGCoZvcBPlJ47rxGqbUNfEpxRwrLMeYmaVu/ps2cZjDoMfO1Bh2ZRwi4YH0Expzq1zfWAUG5/4+z0UlEt3wTHjqu1dqIgCRZfa6kYeNsJ5MHKRwnwj0KgBwvOATRAMPV2Id+CSCYkmf29DBRZfcanyABgxKqYYkNES2kMWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Cornelia Huck <cohuck@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
CC: "sgarzare@redhat.com" <sgarzare@redhat.com>, "pasic@linux.ibm.com"
	<pasic@linux.ibm.com>, "david.edmondson@oracle.com"
	<david.edmondson@oracle.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v17 03/11] content: Rename confusing queue_notify_data
 and vqn names
Thread-Index: AQHZfvNzgICB0qENHEC8eGYjugRwT69bJVkAgABVUKA=
Date: Mon, 15 May 2023 15:10:15 +0000
Message-ID:
 <PH0PR12MB54813927C10C21A323C8E43CDC789@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230505014614.571520-1-parav@nvidia.com>
 <20230505014614.571520-4-parav@nvidia.com> <87cz322an3.fsf@redhat.com>
In-Reply-To: <87cz322an3.fsf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM4PR12MB6011:EE_
x-ms-office365-filtering-correlation-id: b17bbabb-b21d-4d52-8ff7-08db55567cd8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 NaKRvFoyzfya/PFRSgbaeiBF/TTrGDFvjnGD4QsqWg6vaymt5PHwu8XjjASGcuJy2neJirh1nhqK+GMKK3+2eFHoOYYhjNd6gi3MnshBwLTJJmSod1GXm6bKJ3YgtDXUV30u7beJofrwyvWlHP1YAAj+ush8PHQpmwNhjYdPCx9P151JmqOGnRjuTc17OWtM0tnZNJNXET9+bNA657iKZtgP/ggERJw6XhoFZFVJ+PLcZN7Cny/5az7YwFnYh/5Ok32JVA+JnfAAkDqHetvn/WeErMACY4RLduZmnWWB0SiAVab8itoowu0uIuW0wwn0tATcW0RFwG6V40jBR9G5TOZxhRxWWMdfEMJvuG1ZczcFUg3E/eW+2EYRuqtRDi/d1lBZWOev5UhW1tnq0HMAjNwV5djZI4zFD3weAb18Y3/WEACtzoaMQw4QitUlV/58fFHX3KWSFPjHbP9AviIIvhUVfqqCYmeDxs8vQ0EJJWbnMoc0/LuzEWfGEXpcX39kEl759NiiCpABueTO2rRFc72Ng3uGsxbZXV9x6ynfWlVPZrlU4V66Od/eTf/r7LJaktPFBnEh+EzRuwn8Bl15yQ4Ct64aUuWFJME1NsYzh3r7tKIK8H61aZVeY2FmyyqHB5l1rST246hHzLrapRekygyMiuymC0q0H1c8gCKoWlM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(396003)(376002)(366004)(451199021)(66556008)(54906003)(110136005)(478600001)(66476007)(4326008)(64756008)(66446008)(76116006)(66946007)(107886003)(71200400001)(7696005)(316002)(966005)(8676002)(2906002)(55016003)(8936002)(41300700001)(5660300002)(52536014)(33656002)(122000001)(86362001)(38070700005)(38100700002)(83380400001)(9686003)(186003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?yoMlR1/3fVmsX8gU6vy3kwbeyqMGPQWCkZC0Jgy88E79Dv2apJxfN2K3jyg/?=
 =?us-ascii?Q?KrG9tXe+IuN64mYsOiNuTWWiym3MUsqY21cQfkVcMqyHSwb4Cj8cI4tQwjKa?=
 =?us-ascii?Q?OAdlKwid4NjaJHlQeJTWXZq9kEIX6GocbUufT3UdNJl+utalLf3lP4ew3LLR?=
 =?us-ascii?Q?pz3NmN/uNrWmms18UQN6UpYUge55I3d2MAm40wdIeeAySCa+0TtV2xqwzL1A?=
 =?us-ascii?Q?53xPlJyP98/VVDR/F+XY4tPgA64q9oTShh8BuT6drSMrRf9aQo0TcHtyajzf?=
 =?us-ascii?Q?j7cLCBjcKX3tp5gUtlG4Qb91VHvL4LdO5bZU3gLa8nL6DYUN+15wP/2dlh/d?=
 =?us-ascii?Q?KCy4SOo9t+kIpeS8gL2glEB278PzCrZ7j85oU10DKV3/OZfSdg2u0t1mUTsP?=
 =?us-ascii?Q?RO9+Q+Z07oAw3Q4QMoZK5f2H8NPWfUypIbSWR5jsPb6mBvK4rYA45vnVUIzD?=
 =?us-ascii?Q?aX0gPJrUKghrWPgVRevM6lM/gZmFMdr15U35HAiqWkiYn9Xw7Vq8n4GB4unk?=
 =?us-ascii?Q?3hImopok58m4bMWq83Drfuh52PNV/PHKloyItDh9fR/PVwVRuB5ZPQl37zdA?=
 =?us-ascii?Q?DFbuzAoJLxPtLWJ2XMLZB4WzSNpdBS67/mtarYawq/SZRcl7Rgl3N+ZJzmR+?=
 =?us-ascii?Q?HmoA+sFlt5oSUp5ublS0cNz39NPf5U0VDov3p8HRyzEWzOrC7nNJhE9UYxe5?=
 =?us-ascii?Q?XnIrvw549nCCFPS/JYzgmCTxzOvsu/5pICD08aKrFP7h3wdHPtMbML7yHC5q?=
 =?us-ascii?Q?w+TDSEgMsJka1V5BKbw98/jf/CcqbfRdkVZVu9N0wrlJiQXlhvvxiiILRVDk?=
 =?us-ascii?Q?vJGW7ynC7Yyv+2Nf22uqOMjRyVh+kxwbvV8c+RP6ecddgeYlmtTE4BCIdDt+?=
 =?us-ascii?Q?XmP1Xdk1frKhTQJPl3fCH2qDb9vtZRUgCKLfV6+M/WAUtAa/NjM1bPOKe+i+?=
 =?us-ascii?Q?9EHjnERQCHLBjLOMXtGEjeCbVjkMFDmxDGial37vc2AyjNCyq9NDZb+HwLVi?=
 =?us-ascii?Q?pNOLFExFqmYjV/kWHhNVEZRyLU4g99z7mNDr8kmrazYl52katOpI4RRKkZ1L?=
 =?us-ascii?Q?SPJkhVrBC3Hbktm72s1TRYKDBaC2nGknnQon5c0MyT1MMi2hX0PPmb8cWw+K?=
 =?us-ascii?Q?np+PtRye5kRleGoZ0TeNSMZ9BrjpXU/LY21tmDXZFzypQ+SBkHNMAC43jIj3?=
 =?us-ascii?Q?KeiIrifH9kvW5XAgM5QDrw7PeaCwTmS+0dPksJiOXbuvhedOpEiMmlvUBFUk?=
 =?us-ascii?Q?RMXrRwyyl714Y/FfsPBBV1E/u4rT0/4hMY1IRdeUtztuvua/4MuZruhXjO7g?=
 =?us-ascii?Q?up5s7KMt328UuGqDkfzKj0i17qH7xiCbU9yx+bzBg8wzDzVpC99frPaZjoAC?=
 =?us-ascii?Q?8T0P16bSa0YRuuCD2+WwPNoIVz8ZRbZPfg6U3Pkz0VDDpeMk20Bs2JGxTKLF?=
 =?us-ascii?Q?0yQyc8eIf2MvvaL9e8tmxLMVkPRntLiojd8r23GgSSbyXVY9iIVa7mMABs+w?=
 =?us-ascii?Q?zsyayDZibiLOvFzZDPWvs0wl5keJs8CMYGLvp93Sw2tcA1gWBChSPed+R3j5?=
 =?us-ascii?Q?pdDRTM3b/uCmiQOzXczmSWvVCRoug5HMp5t2p0noiRHCLTuMi4Mj21rlXMFW?=
 =?us-ascii?Q?0SXdqyrbruFdalyCaUN0/PA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b17bbabb-b21d-4d52-8ff7-08db55567cd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 15:10:15.2917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NpVCgkGS2GHQBMWbiIv/4dm8dzfyJwuQlaUQS5ra/oKQxTzA5Fv8H5q7I4FZPKCcvBPqKoTIVMw7Aqfiz1kCGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6011
Subject: [virtio-dev] RE: [PATCH v17 03/11] content: Rename confusing queue_notify_data and
 vqn names


> From: Cornelia Huck <cohuck@redhat.com>
> Sent: Monday, May 15, 2023 5:43 AM
>=20
> On Fri, May 05 2023, Parav Pandit <parav@nvidia.com> wrote:
>=20
> > diff --git a/content.tex b/content.tex index 9cf938c..327926f 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -405,8 +405,12 @@ \section{Driver Notifications} \label{sec:Basic
> > Facilities of a Virtio Device /  notification to the device.
> >
> >  When VIRTIO_F_NOTIFICATION_DATA has not been negotiated, -this
> > notification involves sending the -virtqueue index to the device
> > (method depending on the transport).
> > +this notification contains either a virtqueue index if
> > +VIRTIO_F_NOTIF_CONFIG_DATA is not negotiated or device supplied
> > +virtqueue notification config data if VIRTIO_F_NOTIF_CONFIG_DATA is
> negotiated.
> > +
> > +The notification method and suppling any such virtqueue notification
> > +config data is transport specific.
>=20
> Typo: s/suppling/supplying/ (trivial to fix on top)

Fixed at [1].
[1] https://lists.oasis-open.org/archives/virtio-comment/202305/msg00208.ht=
ml

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

