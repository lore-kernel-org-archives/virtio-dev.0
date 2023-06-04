Return-Path: <virtio-dev-return-12845-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60FA6C7EE2D
	for <virtio-dev@archiver.kernel.org>; Sun,  4 Jun 2023 14:10:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id BEFE819090B
	for <virtio-dev@archiver.kernel.org>; Sun,  4 Jun 2023 14:10:21 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BA137986488
	for <virtio-dev@archiver.kernel.org>; Sun,  4 Jun 2023 14:10:21 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id ACE5F98633D; Sun,  4 Jun 2023 14:10:21 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9968C9862D0;
	Sun,  4 Jun 2023 14:10:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D8H594yjApvVwoIdjdOqcHmXa5PnteFdi9utv+nTe335eh9e+Z/f8sFzc6u7OfoArl1/qVwr3hsQcxCnPp1E1S5JAv913ShpYlopT6erq5HERPIOf8A8PYi24NeZhczzuUMT9EOqUmNrXj5f36YqDl8lfptnpJlOMlQPPan2F6DfZUDyN1to/cN8+tzYBt3LCZHeBcRasyXavbnZcyNySYIVWV/clIYX2j0p2QpSUHSqRUgYSmvMlwR6qJA+08vELEYL91XYWGX5O53hyfMKblqlBjzsH7eaLHI2L+G2q0Ooo4EesK9wUrjG1MFOZ2JTC+/JKXdXhdZzXhWdb3My6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lmF4ffvX236sxJLzBIuJ1AzGIoA7fOFrVmyEcVvEqq4=;
 b=HSal/y5R4WWeQ88iyuLg5EtLgWrUJL5uTWG7Rfhvwk5HJagqMGjuM1j6NMXppRBnai0QtWTXp8hHUUJllqcmgu2+ejxS8ciNOfBraiUI0Wjw/YkMHEy14Dv2Jfp0sGLCt3bpknI9Mk65b+wyGZ2omM30i5QJ8uzcAaoG5uKJ6gGBVrwdIfKX8E8/j2SycYEIcV+tIii+h8fl82CPZ0UKsxi4L/lx1TT1HsyKlLaH6cTKBuXiIrmiOOVuAqoKYdKxyO9gGyKUzsin5lza+DtYH5ylzogSCSunfB/ll0ghDpC42IZ0cHhZ7l3987YsK52kyXUkugDWtWoiazZJSbZtDQ==
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
Thread-Topic: [PATCH v3 0/3] transport-pci: Introduce legacy registers access
 using AQ
Thread-Index: AQHZlZHqSKW+Shm580CRlUjcCTH7qK96p2iAgAAAjkCAAAV4gIAAAhyA
Date: Sun, 4 Jun 2023 14:10:16 +0000
Message-ID:
 <PH0PR12MB5481443CD383D9BFA0369151DC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230602203604.627661-1-parav@nvidia.com>
 <20230604092441-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815C9677C9E1F3EDE032A9DC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230604094535-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230604094535-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SN7PR12MB7418:EE_
x-ms-office365-filtering-correlation-id: a2b625ad-1798-48e0-1e86-08db65056bd2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 W0qIaV+QIBD6vkuUOufkKZuz40zP3aEO12QG5uQRFke+/RnYkNWwfmNc0YDZeX/LhJKeU4zePl5K69S6ROYPPfr6i0OUWybUjrM76NxP3ROlD7kx0S8NMDmjOwGLU0MuNPajdQVNqxfKhFt3NTFtq2kyi10vM/zRi4/6Z4OMQVJN3LgyBfjBVdFjX9vmMID953fodzV+eCmfrFCna04rQdDfDx/XibcCpojLEhHe4YrR+bHJ4HYAcQBf+WFfMSR/5hc5TZkZTzelKgUOYZELlwtkUINeg8yIcn+kKQdfnBLcff9fX2JWHQLzuqblVX3b2DwHArG4iDNXUN9FtaMh3FIOyoY8vz35tts7lBkH56l6auznUVVRxgKH5wghlmx5pJ+BO3ktHG93cYNmqjUVJ8BHNtAZInbc20TzGu4BuCjZh+b/S5hfwT/wuBoomoA1t5yAq6p6aBYUQ2o+9q2qJ06Qh2LPSj0XitKrerUtWPFdrN9loMXhNASapcyS/t84t8s3Y0meZQkLQxJ4uBu1ZdtEpQ87IXPoyTmG4qVrf0JgDkSwIkk5YnBRvqLGABdVH67Rl3jAupZcTC2qjhxhuDEhzLNfkg1CC6a292IF4aCWSFVJp0c5TDKxf8/tRxKW
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(39860400002)(346002)(396003)(451199021)(478600001)(2906002)(7696005)(107886003)(33656002)(71200400001)(38070700005)(83380400001)(186003)(6506007)(26005)(9686003)(86362001)(122000001)(38100700002)(55016003)(66556008)(8676002)(8936002)(64756008)(66446008)(66476007)(66946007)(76116006)(52536014)(5660300002)(6916009)(4326008)(41300700001)(54906003)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?pKDWIAjbBWsRRxCzsCTmT1cFEZiaQrwu9u6WK9IcxSvNL6zS+yJOBMviULtr?=
 =?us-ascii?Q?vQ+OTBQ1bAFovH1X8G1EoHhhakwGHC4QOSOGl97cQLrmJaYRLDgstu7YEYtA?=
 =?us-ascii?Q?hRdiMBFY0zXiRDe2Bdm0Q92vfWUTXFbnm0llx0IMHD6uoXD4/2UPSxjjoMzD?=
 =?us-ascii?Q?O0bdymhNLG8zfnrGtNvOSxcZJIFv9qN1YQAF7TNPAqAj2CjypEFMBxZAqITp?=
 =?us-ascii?Q?2oSnA+LP7XuYcAFw+gV8ETQZsl3HC6+6MWGoNIizQASSt++e1jvHOP6qseSJ?=
 =?us-ascii?Q?How1Xzg8I/1efmbMcVynelmtxtqsvAVkF5ZMeyw8ik3g3EFxNcgRvP3FJ5q2?=
 =?us-ascii?Q?T2+GT8h2O4r2wvi/NyAaRVC0wWqMzYSd/p0538VbvHk3DWxNuoLX4cmekYAu?=
 =?us-ascii?Q?HaJQbOOneGsd3JkbMfVblRagjYk3YWQqlJjAj90DLRszwFDCT3HCdmskWO2y?=
 =?us-ascii?Q?h6qNq9J9OCUW118ZvPhj6op/XFe0mliIKKpu6RxobLLlkRuqs1RcuVt1V7wA?=
 =?us-ascii?Q?BKrhO+8ygeYGGMgiCbIC/9dr8TIqLs+5u1NF3qI+tPR/+ijJokmckIEc38Fa?=
 =?us-ascii?Q?BspsIx5DGGa9An0KcdiMF63L1HLq2DZCe/uzg8fjmL3+iyOpmVPIRrfL1Dd3?=
 =?us-ascii?Q?GBLCw/2DLGGD7U/ZsTA6AV00txsLj9iy3uhJPVz84xS9yjh71yeY4mh72jkx?=
 =?us-ascii?Q?c1Qpb4e+7dkW4s8NHB8BTfYXeHkcz7T+a8JPtLe1CximtDlR2EfpscMIre0m?=
 =?us-ascii?Q?DpfuJGeoG5HbyGJSTfq+NEM1SQvKN+GA6Le6UudSOoffVCaYhvoI03pm2Qq+?=
 =?us-ascii?Q?YjLurNZQ5njTJ/7MuMU03Wp85DQERgGed1zKh1ZGHDn1Pw6pxd8Z8m5ZlM0/?=
 =?us-ascii?Q?ScmEWjlV248X8Ae2VIRf+OOwnsBlcD4knYfUmI7VB+WW/53ldtgHV3N4HFnv?=
 =?us-ascii?Q?hlcemr30kpPg9/r/7qiEozTGc3/ws74T38ISyU52njudnCVbHzWeHipZ+li8?=
 =?us-ascii?Q?6VLgT+3BeCCauUTQAtrSG8fRpydeayz6LHz4mkSPRL7CRbH3yUcuAWYm5w6D?=
 =?us-ascii?Q?gHDtyG+0eP5skiM3mPaXtnQdYHiNv7sd7OoglSmCWDiu5JorIpbewuLMmgfi?=
 =?us-ascii?Q?LfuXIGdl3+juLy0gGnikYU/iDUYPZc7Iq0eG4MMpEt9dsnmRc5unIE4NZC8c?=
 =?us-ascii?Q?zYj3lD6vo+CQs9pXHB3rzX+b1KpuX7EKw6UGgsmyPJ+vT2W9FNyKudApgywA?=
 =?us-ascii?Q?t+2kRnwC+59r0lKY+aQ+FvLSQdrlfGo6xkQ6BvyPmBdq+J1b5p/NqYJzSUUi?=
 =?us-ascii?Q?ooeGiW0jRvxvOH0oBv4cBaNhoqLf6FwQvHjeBDX1+ou93lD7J0GmYMLXOW1r?=
 =?us-ascii?Q?Wh0S1V04NklhXuUEXQqrUbBxrrMqWjHSllIejuNnoEa6oAQfFmwN6vm9Mc+z?=
 =?us-ascii?Q?LGesfd2OgOc3Wfq02bxFlY/OIgne+Wh3AJyCNdM0azDcTf2GoXKMliyIQg9S?=
 =?us-ascii?Q?fs9Uccwix7ZBTOLeSmzBH/YIDUHBk6fxqNSiD8oKbjILbiHwMRacnxgXGSrR?=
 =?us-ascii?Q?YeAMYSsQ3usp1vt2zhg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2b625ad-1798-48e0-1e86-08db65056bd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2023 14:10:16.1113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FzI1v92EhcP2JeFDI0FE9+3hLa3ur6EvMXxPCzRuvsuEgH5VF6Gl4B1lvVaZ/S1ihFN7aHmcjynYyc7nZ6180w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7418
Subject: [virtio-dev] RE: [PATCH v3 0/3] transport-pci: Introduce legacy registers access
 using AQ


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Sunday, June 4, 2023 9:56 AM
>=20
> On Sun, Jun 04, 2023 at 01:41:54PM +0000, Parav Pandit wrote:
> >
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Sunday, June 4, 2023 9:34 AM
> > >
> > > On Fri, Jun 02, 2023 at 11:36:01PM +0300, Parav Pandit wrote:
> > > > This short series introduces legacy registers access commands for
> > > > the owner group member PCI PF to access the legacy registers of the
> member VFs.
> > >
> > > Note that some work will be needed here to fix up grammar and
> > > spelling mistakes.
> > >
> > I already verified using codespell but I guess it missed few.
> > If you have specific already identified, let me know.
>=20
> I remember seeing something about a drier somewhere :)
>
Yes. I will fix it.
=20
> > If not I will run a different checker.
>=20
> Yea, pls check grammar too.
>=20
Ok.

> > > > If in future any SIOV devices to support legacy registers, they
> > > > can be easily supported using same commands by using the group
> > > > member identifiers of the future SIOV devices.
> > >
> > > Yes, with the exception of
> > > VIRTIO_ADMIN_CMD_LQ_NOTIFY_QUERY - currently refers to VF BAR,
> > > subfunctions do not have it.
> > A subfunction will also have its own BAR carved out from the PF BAR.
> > A subfunction definition will be as contains as possible.
> >
> > > Can we find a way to have it in the PF BAR instead?
> > At subfution level also it will be a BAR number, which will map to the =
PF BAR.
>=20
> exactly. why not support this for PF too?
>=20
> > > E.g. the notification can include VF# + VQ#?
> > > At least as an option?
> > No. we discussed this before to have each device on its own BAR. Hence =
no
> VF# in the doorbell.
>=20
> you said that you want it but without much in the way of explanation. I'm=
 still
> not convinced it's a workable interface.=20
You said "AQ is just fine" in v2, this is contradictory to what you write a=
bove.
We cannot progress with dual comments like this.

> Will it help if I get some feedback from
> windows driver team on the design?
>
May be. I am not sure, given that these drivers are not inbox, they are not=
 in purview of the OS vendor.
And OS vendor improves the OS APIs in the future for new use cases.

Even the SR-IOV model in Windows is not elaborate as Linux AFAIK.
So I am not sure how much value add we will have.
But sure, better to have their view.
Will you please add them to the discussion here or I should check?

Did anyone use vdpa acceleration on Windows?
Do you have data points that someone wants VF acceleration on Windows hyper=
visor?
If you bring the use case, I would like to see there commitment to develop =
the code also and it will be great to have virtio there.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

