Return-Path: <virtio-dev-return-12767-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0C57C77B73
	for <virtio-dev@archiver.kernel.org>; Sun, 21 May 2023 13:21:25 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3F66568467
	for <virtio-dev@archiver.kernel.org>; Sun, 21 May 2023 13:21:25 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 378599863E3
	for <virtio-dev@archiver.kernel.org>; Sun, 21 May 2023 13:21:25 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 29E509859E7; Sun, 21 May 2023 13:21:25 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 115529859E6;
	Sun, 21 May 2023 13:21:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EF5TssvuO1eTdATHl5BEVK+u4Q1jSx4TKV+DIKI/OtTLFZ1PRpAGSmAL9TYKlipVqNbUimebdhpTVQyjDF3qGD7H/xVwB08ebbvrTzT5blh4Zrv2DadYNXltsr51/KuSyR1xjPjQIBjXXiqMW/0FZAGbaERuGhUp1WsghBFPXfw6+Ns8PL+jdQyWOgp8pq4Ktwu7DGNmvuEEMwGigbpIvuNoB0tMkVMpcNS6fKZYspL20yHQDG9v1SnzRcFoV3Wb6/xYRZRNSAXlxu3I5fQrzOd2uhmzthyYU0xfNxDj7LDYJebE4UlEAWxU1fHq5qGhfj+aHZ1/xyKMiAJVt21W7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLDd68Wdnxxsj9uY3VdOf4UHpCwjaIYsWiTAVZ1rews=;
 b=QKR3uVk+nyDAquB0vuzq4psrLfTt4MGhjUJMU8dAU41goqFQQ5itzsRzcGymZA4Oa5l9MwMQ5MkFrmbiXdJ5DavV6C9wSRAoLSE4X+f6DmZpZXFVbOFW1PS4NPtcslR76NmH6TakYYakBDop7g9YDCvJiaL9yLy2R21xsIuBSKbuJyRo2xhBgAovFp5mJNDFNFwBPepWhWm+x7vdBp5m0knDqYKuGSUBK6PRcPLUqC1AVAR3PSazUy8Qkx1VHCuyn8XTITSjviY38V8t72u3piJQI6lp0PagvqHSvAuwITdxQLklVmsaBCYuqWhcSnsMIcL2POmY33tAh9DAdSIWbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>, "david.edmondson@oracle.com"
	<david.edmondson@oracle.com>, "sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, Yishai Hadas
	<yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [virtio-comment] RE: [PATCH v2 1/2] transport-pci: Introduce
 legacy registers access commands
Thread-Index:
 AQHZf639R6aTQu3GsEiaqC7Dtr8vQa9eBfIAgADi2pCAAZmGAIAArnkAgACuQ0CAAqt6AIAAPtmw
Date: Sun, 21 May 2023 13:21:17 +0000
Message-ID:
 <PH0PR12MB548161A2D28C387C9AF23B81DC429@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230506000135.628899-1-parav@nvidia.com>
 <20230506000135.628899-2-parav@nvidia.com>
 <20230517013839-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54817CBB98900B83C4F30164DC7E9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230518153640-mutt-send-email-mst@kernel.org>
 <20230519015520-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481AABA8A22DC088B5D7CFDDC7C9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230521050829-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230521050829-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DS0PR12MB7995:EE_
x-ms-office365-filtering-correlation-id: 7796b747-809a-40e2-f207-08db59fe42b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 dLGDNzeYBZhF30zpZ0ALk3af+muUimqGN/3+qNd1LGvGCGqm1eYL/feCgZRfC/WjiSW+tMPc1xcxR/AEzYZsGl3iXIm3N86BqIK9siuHUkvXWDFL/ODat7MSRLt7cVcTKCV8fvqaVe5yochu4WpWPZks8CbGvpmJ2WLqd1mBVXWPzzdowYcIdQSCRLspTj/wy3mUV70AnByoAcYAxzJKTkerNy1aDkERFkyqnqMSqfyWzVqsnWWaWIw7Rj/K/6mbELEweUsF6VmmViP42y5oTlFG9LklO/WAclyZRIt346cImGkjcrT74+zyaRSYPidVb9/PKiL9QpXP4YLiLsura0seGtDTdy23Us+j3LG0FDjv2Or6NOxW3Jh1KM9wnbdLsJTtwaYh7cJX4fL7XGCF0wuewLI1OCLHNzOjgKpvQtKgYmtgl8HxN9lVRV4SMHUrRb06jwsmCrTlxFxrZxHSWkavMFZi+hyuuKUIdv6iaY/ecqCX5RKJn5yxRGOfcK/Uor8gnZBZsGKLinI0AjEYrLsnAHGus9FFFq/9GHl2PXI/0E2TMC1nrJGHkFQ3bxqVAx9qO72d4zJLcafwJwVLKQ5bi6aTc1zx9Ha8yIWP31gXLJBvqNW2k6fN5mFKVYe9
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199021)(8676002)(8936002)(52536014)(5660300002)(83380400001)(186003)(26005)(9686003)(6506007)(86362001)(107886003)(122000001)(38100700002)(38070700005)(41300700001)(7696005)(71200400001)(33656002)(55016003)(66446008)(66476007)(66556008)(66946007)(76116006)(64756008)(316002)(6916009)(4326008)(478600001)(54906003)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BKs48ozzZ81xSY/MrwZ8APL5jfowuBCq5tcNHlV7A1p7fCa85lnahC6Uacqj?=
 =?us-ascii?Q?Y3nyRuw+Y/kkTYWtdxKu1+PQoULySHewPbQ9Qe40aceoSo4AjQ//dPowkxxA?=
 =?us-ascii?Q?BU+HhyY+Tp6pOELoiMACHGyBEf5PCgkEndMU2zElZpU53r7drwJwUbY8hT6G?=
 =?us-ascii?Q?mIsj2Hm8Tju3RKHrdr/af8lkoGy9GTmU4Vj9cAU5hj7IL2LAnWqvMeq8g/bP?=
 =?us-ascii?Q?mzZ3arqKh502jjHrR4BlWbvA4fw+cMo5x6kOOKUNw60YVYdNX9V9h9Up/6EE?=
 =?us-ascii?Q?Gqj1WASuMkDMihe8XB5htJc4ASKMaw757GH6YB/4WftQjW6vk3SVSG5HBFzF?=
 =?us-ascii?Q?UqOb5wKdPmplTO4f9AdI/sEsi2QyiIlOAQmq4F6MVBy6SbdcIZGdk/Ks9LHc?=
 =?us-ascii?Q?2NObW+3MS+l/E6rKF7lV7oIddwFYQBMjjclnljqIE6B4hy5yBFfiALgt420N?=
 =?us-ascii?Q?pZxwUk7rUWtGngovEPEW7scJGNF3QEv2JXsntORkh/Smn6LFOMuat7feSGvt?=
 =?us-ascii?Q?D3mZ8G69M/NSHLosOslRZXVDO1EyaRyB1ebwyXhsL33ZlkOir6SxC+cwbOdC?=
 =?us-ascii?Q?Ib5IqRc8Xs+jAjcrqqE5V7MEZ9O08KLR7eEviirYJf0qic6W9THO8Dm9vslt?=
 =?us-ascii?Q?jLP48r93t5YdrMBcfCggjOd19N2LhMPHl/C4f2Wc51rRdyK0BLGQqha2NIq0?=
 =?us-ascii?Q?stwc5LD46uYRGdwPLfNPhJsp10T9T8dDAYXhXaTiS45EZomrZ0A9WgQbFMrB?=
 =?us-ascii?Q?jU5+8Tn/Ym0udvm4hflbKeVfTWcEq3uLv5ds6qLzwy7uRK5v8Lb3EeoxFAp8?=
 =?us-ascii?Q?XvsYWk4VQhfb8eYvrnGK9VVrGqmS23DmFLTQJIe4iEAVB2ueoLtz/pITPsXa?=
 =?us-ascii?Q?QEzoYFM90fYeXhpTeO9Ib5rGcZuzx0EbyimHC+dP5Mklf1c1PJtNYPWo8Utz?=
 =?us-ascii?Q?vq/inUd5VT5jlvyv5hvLPiy6vNjncoeR0N/T5zGyt5HejfcElQPqz59nVOas?=
 =?us-ascii?Q?ULc09+YCQ32aBuETtCEdtHOLCBKQqI80NMDLeq/RpEnUbb8Apzfl9DzkgQk/?=
 =?us-ascii?Q?GShO6hqynaUDZeAfw7IiCsYQtRg6CtXKp2YVSCcEv3R5gVQq2aNKWStQ6vH4?=
 =?us-ascii?Q?uyCqdlX1olwYFc6Q1TaAs2ZXQEpzMsheBjPsX0V4EUxTkHrZXE06hQQ62n6D?=
 =?us-ascii?Q?h5T5aPcS4T0pK0q7UWACAI2rOFD6FLiBvkCN1l4XTDcXA4aRv4u1YODhsuYI?=
 =?us-ascii?Q?Mi1f9kLyaO5CrEWI4nqgBOK6dvvyWSrZOST/XorToRGmL+t0nkc6JNsHaCjM?=
 =?us-ascii?Q?eSl0sP116wbF7DrAfTwe4VaACBmwv8uIERJV0QZNXhMRwoqSy2Aj7Ia2QCl1?=
 =?us-ascii?Q?8ZYhgbL5V2C9mxLain+mAEzNUWksHUEfa01VPJ/p5+sIzY1JqDwvmyHOe4F8?=
 =?us-ascii?Q?gFVTKZmL8cgdmpjBbbbCNLNpoYVMSZ9vrysg7VtiTnJ0hvROS3ueTGzUCFdj?=
 =?us-ascii?Q?cKBwvF73rSyeErBmyVXmIGD2qQnmu+LpRzLQy3fq0nUTgSC7NMtcq+g834S8?=
 =?us-ascii?Q?s/cbtXIu6ImvYX2UtG8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7796b747-809a-40e2-f207-08db59fe42b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2023 13:21:17.8507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kX24HPHVuk2Mv9JNy2YLiG4pUAEV1QbOnRff8RJKXaUsbwXcQ430YdzYs08hA14Y0PsEQFShmXvwm0kokZ1CXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7995
Subject: [virtio-dev] RE: [virtio-comment] RE: [PATCH v2 1/2] transport-pci: Introduce
 legacy registers access commands


> From: virtio-comment@lists.oasis-open.org <virtio-comment@lists.oasis-
> open.org> On Behalf Of Michael S. Tsirkin
> Sent: Sunday, May 21, 2023 5:17 AM

> > The Notification of the VFs are on the VF BAR for modern or legacy.
> > One needs to build additional cross forwarding hardware from PF to VF f=
or the
> doorbells.
>=20
> I think doorbells are driver notifications (linux driver calls them kicks=
)?
> I don't understand what you are saying above really.
> what can and what can't be done?
>
VF has the notification BAR region.
All 1.x and legacy such notification lands on the VF BAR.

> Again all this idea (as opposed to Jason's transport vq) is to have a sim=
ple
> software model. Attaching a driver to two devices at the same time is har=
d to
> achive e.g. under windows.
>
Yet you initiate same discussion point that we already discussed again afte=
r summarizing.
A driver is not attached to two devices.
A driver is attached to a single device.
A device uses a parent/owner group device to access legacy.

Software model may evolve over time.

>=20
> > And it cannot utilize what already exists for 1.x VF.
> >
> >  > 2. It should be possible to send notifications through an admin
> > command too,
> > >    otherwise admin commands are an incomplete set of functionality.
> > >
> > Yes. it is only for the functionality. As we discussed in past already,=
 this will not
> get any performance.
>=20
> Performance might be ok if hardware disables kicks most of the time.
>
Even for the first kick it is order of magnitude higher.
Kicks is the natural tool for the low latency.
=20
>=20
> > > 3. I feel using a capability to describe legacy notification
> > >    area would be better just because we already have a
> > >    structure for this. make it an express capability if you like.
> > The AQ command interface is far more programable object than PCI capabi=
lity
> to return this admin info.
> > Hence I prefer AQ cmd.
>=20
> I feel your preferences for 1 and 3 conflict. If you really insist on kic=
ks being on
> VFs then at least let us make VF driver in the host simple.=20
It is straight forward.

If you prefer the "offset" example of past,

If (legacy_offset =3D=3D queue_notify_offset)
   *db =3D guest_supplied_q_notify_content;
else=20
    virtio_net_send_aq_cmd();

"simple" is really a subjective term in this context.

> If it has to talk to PF
> driver things are really complex. At this point we are very very far from=
 VFIO
> model, and then what exactly have we gained by implementing legacy contro=
l
> path in hardware?=20
It is in the VFIO model, legacy largely falls in the special path for backw=
ard compat for the hw devices.

> Let's do software with maybe a couple of features such as
> VIRTIO_NET_F_LEGACY_HEADER.
>
We have already these design choices and tradeoff in v0 and v1, it doesn't =
fit the requirements.
We cannot iterate exact 100% same points again in this summary discussion.

If you have any different comments from v0 and v1, please share, otherwise =
these commands should proceed.

What you hint is saying hey, "transport everything through the PF, then why=
 do you have a VF?"
We again past that discussion.

This is different requirement, than=20
"There is a VF passthrough accessible directly from the guest without a VI,=
 some of them need to have legacy support also".
Hence how do one make that legacy guest utilize it the VF in passthrough ma=
nner for 1.x and 0.9.5.
With this proposal 0.9.5 slow registers are accessed over the owner group a=
dmin PF keeping the whole model and functionality intact.

This is it.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

