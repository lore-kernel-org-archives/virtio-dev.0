Return-Path: <virtio-dev-return-13913-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B9ACD342E
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 07:53:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id DFAD62AEDE
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 07:53:21 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B46D198668A
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 07:53:21 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 967AA98667C; Thu, 21 Sep 2023 07:53:21 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 85E4898667D
	for <virtio-dev@lists.oasis-open.org>; Thu, 21 Sep 2023 07:53:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X52eAjs9DaPy7bbIjcBW8/ZWG1xcTy+pb5sdP9FX2ccTH5N0NtIkcugF63dLezrAfry5Ip8wD84ow7BegHy9AmgBKGfn6DaI2c8gIYaUhMIPx6D0MvaliGzpe92YSXHxjYCfvc0L/2m2sTGIRoZ+UGxA/xa/wdNI5mIHFDBJ4JLGbyETyoy4S8N7HRuW1eX2JvWvFG9Sv69/6RT5U6OKWJV4HLhBgXnqduV0YFRywRZ+ByEAi+PV/qEL3W1+Pi/UtKsdMWz/eZrSYoIUXUIDur5DKI+7utEgGujmZCGT7ulRtMMDULHzaRT4Wo5fsICZG2Jb7XQDObvnUs3DKGEEDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uURhs/B87kQ8B5Yg1VKtvCjPOQdgNAQik3Y2OOpb2tA=;
 b=h/PX2+dmenSthVx83VkOUhJREsFZQx5tyS6b7v3L/xy4SKVdReRZU0bFxzRCCnLXpux4KAqxKAFweqM/RTeIaW7PjxEldx4bIHslBnRANNS7iaoLlP+RHxVXlBrE1j4YKXXE3fZB4msmfdSm6MQ3w0j7CMZ62kjp2luoNtL33elveZg5awPaaceGijMmrQyEcSl8D7mTJj7GBSS7Twoeexn3H+eEOfIpDlO0gI0qfjOJLH3dsyu2l1PKOKCY+SooAerTkFNDGseItt2aBQ00X/Hi2UPWKVboqTpEyWLgr+5/rSDUL8HHKrR5GHJks9UlvtNHJU3LJElSY5h7a+Q42Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "Zhu, Lingshan" <lingshan.zhu@intel.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Jason
 Wang <jasowang@redhat.com>
Thread-Topic: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and
 vq state
Thread-Index:
 AQHZ540fvvI9R/h+mUufqKbomRy5frAegLUwgAFrbQCAABUsgIAAD5cAgAAA+ACAABKeIIAABNaAgAAAXmCAAC3dgIAAl98QgAADDoCAAk+KgIAAS2wAgAAM9QCAAAwSAIAAChWAgAAB0VCAABiEAIAAJySAgAA6DQCAAH/8EIAAIYaAgAAAnQCAAAZZAIAAAKfwgAAT/YCAAADbUA==
Date: Thu, 21 Sep 2023 07:53:18 +0000
Message-ID:
 <PH0PR12MB54810CEA225EA1BB896AF7C2DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230920084058-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548110E53C924C984FA24A49DCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230920101402-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54816F8341A77E63831316DBDCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230920160218-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54814A89793CF796412D6A27DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230921004957-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481E096E0298F29C9EA73B4DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230921015810-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481821D526E376771E70204DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230921031129-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230921031129-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SA3PR12MB9129:EE_
x-ms-office365-filtering-correlation-id: 9caa83bf-b371-4c3a-20c3-08dbba77d1dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ddWGJ+s/de2bSzINQyXr4Jzf8stQlqkDmEoOUDeqZ3zCEY9q2vyZHt/2kvBy50fvDWOd+IQm51yAsdR4Ky0RRBnXin9BgoLG95zis90QPV++n2+NQ4pQ3IbCwOn7V//TAPdkfQta0yHbXpeRfc7MWfYXV0jwjbdAmPtgwqxhV+t4wZReMPU2rTL7Kb/0MrH3eqL2UV8PEwU6b7I9VbOv/6Z3p5Q03TUfCknJ65lBXPApJ+unuqcGjY5JQOdC+QFeyotzoboYgbQvEhqpMml/vdVQGCduFd62GnFaYK79n6r66T89LIsTczJaiThk33cNRc/xFSawj+6P46S2IQPIcwmTEtnCjI8fo+NsvkJbLHNl8Fcn4+wVa0wMWuZe2J4nbvKrDSqgPLR1g7PoZJwV+X/xxVF3wWRPmkiinr7rQLDjnS9X6lqOuPdsbB/N9WMadMT5QzRV2uiMNnweDvesMNx5yGC3nI73J5rBgKEtU65Pw1hwUavFulpyehyalqaEDswCFEzvEqyXwutt2mesdjx0JDM5Cjr0liyvvpaIPjM6Q7tm5roM6z9j6dIhdTvwJI/Ml/KFW+kGwfWP16TZHSmg8chGakjc6i2TFQoBDK1yMNh5Jf0WSYucQl8Z3GjGqsYJtLpHuKwfud6WcKdNxhlEpoORIeV43j8SmydDurI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(376002)(136003)(346002)(186009)(451199024)(1800799009)(41300700001)(84970400001)(966005)(4326008)(8676002)(8936002)(122000001)(54906003)(66946007)(64756008)(66556008)(76116006)(66446008)(316002)(6916009)(9686003)(66476007)(83380400001)(52536014)(478600001)(5660300002)(26005)(71200400001)(38100700002)(6506007)(7696005)(55236004)(38070700005)(15650500001)(2906002)(66899024)(55016003)(86362001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nkR3zuXeFpUeOYylWJpfNm3GseL3d7NvP3BoTu05x0v2vcgKJSxioGoAYmvO?=
 =?us-ascii?Q?cRHWVl1C9VWJ0YkMkVn95v2gf6Db0TIUuhoZBtubtADu8PGTvc+3CAN3gwWG?=
 =?us-ascii?Q?r/CT967tjEVmX9HBjaIc4c8K/4XFtT608ROpnW/blw19rbjE9fwIEaIRlLyT?=
 =?us-ascii?Q?tiSmWSv0aR1vPdoRHgE9pfEpGGOaptuUmjHntPgEgjM+a2rd9VK8WdQrFGcU?=
 =?us-ascii?Q?bujTxdsjSQJCf1KQImrktv8db1UjXo9LnnHGbFGSU/8LkP4oFFXMKbGbE8H/?=
 =?us-ascii?Q?88OHrVNv+T3GTCk3w2oYqsgnnjQPJan/lan/XweA89VhmLFR/oUWmLNcW1y4?=
 =?us-ascii?Q?RVrRnFW3nLdn/2gb57NgD4hMetbOq1DgMvf3S4/s8Ssqt4xty9P7/hz2vTG4?=
 =?us-ascii?Q?lTAjKggNDaP07LnV2/lYIGdvEYopmEPR7y46ncfjwLDa3wVnv8WmpcA4ilTr?=
 =?us-ascii?Q?2l3cMDGLUylG/SSPcb6B8C1do/OwNQB40+5ffkXVRZMt1nPnY65qWjURDCfB?=
 =?us-ascii?Q?5oY/7wxanY9SVw0rVK2hMcAzoSa7THh7Z5KXNYm0hMPpDwj0Mp5YfOS6Mytp?=
 =?us-ascii?Q?ULXWpAJyXoiA8PlMqomT3zoUwO+7uRs/qLSBytjNTMz+xXG8BiUmmURfFHUT?=
 =?us-ascii?Q?KLLHKPtLhQFbs6PUkiJS6X7wOPHC6aslGEcWpFXoxSxe1FdLcEYhIq/owts8?=
 =?us-ascii?Q?ec38y45eSrwn+jUxuL2idHP/sZDn0JN/eckP0CAC1IVEBNvO1ZIyvsv5rC5m?=
 =?us-ascii?Q?wVZ6XGyEflt5F9Fw3ydg4sVhJDhno8806QWER4qEBMTVCuM6PN02z00QfH6E?=
 =?us-ascii?Q?YhSFKd2McvGAvIcA4G7rE41dOmbSUx1oWX2+uHGvDz8CxflwWhmqsflB7mFc?=
 =?us-ascii?Q?w49pAlqBRcaVD8wPPoRGgBDRBVXtX8FczeHKZMgh8yi1uPmJJli3e5J7raNf?=
 =?us-ascii?Q?CfB+CqGQt9HDSvhC4JcvkNYM9CEMAQ9DOXPCGcCGoP0yHkVS5d86NgxiVGLk?=
 =?us-ascii?Q?O4/Ff7pGSUQ5e5nSpy4NXrW/i2gNgesy2nakwzNtdW/f+8r/ddBLnVWXYawT?=
 =?us-ascii?Q?z04ZaAeW+9+J65vQcGca6RwiusrxcEHliZkKPOWbhthl4fs/Vvx3OnBCN8gM?=
 =?us-ascii?Q?Nib192U+FrvELA99D548izP82Xdqvsk4iAhwmlC1my9a8HbwJMWGWagTLKBl?=
 =?us-ascii?Q?smxiQewFhTMOKvbaDeOR3Rbp1dybKEOTqRYVN7+1dQir6RPpt/nX9Mx11rLb?=
 =?us-ascii?Q?elIr9MS8GV/QU346ZneljDhy3lzQsbz+0xMTYe333EgBS6hRXvMZYb0aK89b?=
 =?us-ascii?Q?4Fu/eylPzuKy+VMrpcyA5Vm16Z2TGmXl/rGYbkoxXbcpYC3G1nEGC+mLtWc3?=
 =?us-ascii?Q?DKWkX7TEa+tddUthedNfqJ62OhpdPtrfU2VsUMwUtz5D8GpNupKWYdvAdGsT?=
 =?us-ascii?Q?egh9P3ZJpuhCVK1GSFB0rA63eX3Ez2gdjh4TxSB5RbEGtyZNHyzAcwDrgWCQ?=
 =?us-ascii?Q?EOTkQvRp9fMDxIQd/zDLf/c4Ri+D5useqqEiO/U8H8zgQAHc8dTSsu0iXmKP?=
 =?us-ascii?Q?QXnjB7GtmkpKpjqylrw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9caa83bf-b371-4c3a-20c3-08dbba77d1dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 07:53:18.7527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JQlffU6deDfvTsCGVFOP4+7P6EYjwmjMgFTdRmlognTL1IUbAAap14+76i4xCJrFK/SgBX83x978Q1P6Fosvag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9129
Subject: RE: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq
 state



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, September 21, 2023 12:51 PM

> > > As I said, doable without mediation but already done with.
> > >
> > It is not done in the virtio spec that can work without mediation right=
?
>
> have trouble parsing this sentence

I mean to say,
Virtio spec has not achieved mediation less, device migration.
Virtio spec has not achieved device migration using mediation.
And two proposals are trying to do it.

>=20
> > >
> > > > > 1. For mediation something that works within existing mediation
> > > > > framework - e.g. reusing as he does feature bits - will require
> > > > > less support than a completely separate facility.
> > > > > I think Zhu Lingshan also believes that since there will be less
> > > > > code -> less security issues.
> > > > >
> > > > With approach of [1], there is less code in the core device
> > > > migration flow
> > > because none of those fields etc are parsed/read/written by the
> > > driver software.
> > >
> > > What is or is not executed in a specific flow is a separate question.
> > > But the point is vdpa and any mediation have to talk virtio things
> > > such as feature bits. So reusing e.g. feature bits needs less code
> > > than operating the admin command machinery to check what is
> > > supported. Yes, you can operate this machinery during setup and not
> > > during migration itself. It's still less code to maintain.
> > >
> > I wouldn't go down the path of code comparison.
> > But if you want to: we can take a concrete example of what is done by s=
imilar
> device who uses admin command approach.
> > The admin command-based approach migration driver is likely 10x smaller
> than the actual driver driving the feature bits and rest of the config.
>=20
> yes but mediation driver already has to do feature bits. so if doing medi=
ation
> then the cost of adding this specific extension is low.
>
I thought first you were counting the cost of the code and not the spec in =
your point "feature bits needs less code than operating".
=20
> > If one needs more precise numbers of number of lines of code, I can der=
ive it.
> > As features and functionality grows, every line of code gets added ther=
e in
> mediation too.
> > I agree such mediation has value and use case, as we know it is not the=
 only
> approach fitting all use cases.
>=20
> Do you see how this extension is easier for mediation than driving admin =
queue
> though?
>
If we count the total cost of code than building the mediation framework + =
extensions, than it is not.
But as I said, I wouldn't compare two solutions as they are addressing a sl=
ightly different requirement.

What to compare is what can be reused between two solutions.
=20
> > >
> > > > > 2. With or without mediation, the mapping of commands to VFs is
> > > > > simpler, allowing more control - for example, let's say you want
> > > > > to reset a VF - you do not need to flush the queue of existing
> > > > > commands, which might potentially take a long time because some
> > > > > other VFs are very busy - you just reset the VF which any unmap
> > > > > flow will
> > > already do.
> > > > >
> > > > If I understand you right, to reset a VF, no need to flush the
> > > > queues without
> > > mediation too.
> > > > Just do VF FLR or do device reset, both will be fine.
> > >
> > > Not to reset the VF - that's a narrow definition. To put it back in
> > > its original state unrelated to any VMs.  Nope, FLR is not enough -
> > > there could be commands in queue addressing the VF. If they take
> > > effect after FLR VF state changed and it can't be cleanly assigned to=
 a new
> VM.
> > >
> > If you mean the SR-PCIM command, than it is virtio spec to define them.
> > We ratified this recently in the PCI-SIG of what gets cleared on VF FLR=
 and
> what stays that SR-PCIM interface to do.
>=20
> Interesting. Which ECN exactly do you refer to?
>=20
B405.

> > So if other commands are in pipe, only after they are done, such VF wil=
l be
> assigned to new VM.
>=20
> Exactly. this is exactly what I meant when I said "flush the queue" - you=
 have to
> wait until these commands are done, then do reset.
>
Not exactly. VF reset is fully controlled by the guest. Hence, it does not =
collide with admin side of commands,
Same admin command for dirty page tracking and device context do not mess w=
ith FLR.
This is the critical because VF FLR cannot clear the page addresses already=
 reported and not yet read by the driver.
It is covered in admin proposal.
=20
> > This aspect is also covered in the proposal [2] in the DISCARD command =
and
> stop dirty page tracking (aka stop write reporting).
> >
> > [1]
> > https://lore.kernel.org/virtio-comment/20230909142911.524407-7-parav@n
> > vidia.com/T/#mf15b68617f772770c6bf79f70e8ddc6fea834cfa
> >
> > To me, frankly, both methods are addressing two slightly different requ=
irement
> due to which it may not be worth the comparison.
> > It is not either or.
> > And so far, technically what I understand is, both methods has its pros=
, cons
> and limitations due to which both requirements (passthrough and nest) can=
not
> be addressed uniformly.
> > Both has its space for the solution it offers.
> > At best, two methods can find some common ground of commands or
> plumbing to reuse, it will be great.
> > If I am understanding is wrong, I would like to learn and discuss.
>=20
> okay now that's progress. what it would be great next if there was a revi=
ew of
> this proposal that does not say "just use my patch instead it does the sa=
me" but
> instead says "here is how you can reuse plumbing from my patch and it wil=
l
> address most of your use-case".

I really didn't say it, but it is easy to miss out or interpret that.
I assume your comment applies to both the proposals.

This is what I proposed to Lingshan to review dirty page tracking and devic=
e context from admin proposal if we find it useful in his v1.
He didn't explain why he cannot use it.

Lingshan,
Can we please start fresh to review requirements of both the modes (passthr=
ough, mediation) and see what all we can converge to from both the proposal=
s?
(before sending vX of each series).
This will help us to unify the plumbing if possible, on both areas.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

