Return-Path: <virtio-dev-return-12865-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADA14C7EE23
	for <virtio-dev@archiver.kernel.org>; Mon,  5 Jun 2023 16:05:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B3DC160340
	for <virtio-dev@archiver.kernel.org>; Mon,  5 Jun 2023 16:05:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 13C0E9864D1
	for <virtio-dev@archiver.kernel.org>; Mon,  5 Jun 2023 16:05:31 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8DCAE98645C; Mon,  5 Jun 2023 16:05:30 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F341298644A;
	Mon,  5 Jun 2023 16:05:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yz1Qc48WNpSD2bDvOspQiELCJ5IiNkMD8hlyc+VAKYqY/BUgpwWbJewhO/+lYMdajLy+xigWVmQ91nrkWYvdGdfDyXrYxDz729E8ML9/oWa3YOHQ36jSyOLsuVmokqD1+vqkArpE/jJ3839n9zZjGvCR6xlQdx9lm1SXKGwSKLeA3zGA88m8mBjCXqY9k6eLRjQK178E+k4Uv34iRCPiBwfSHcs7Qk9uMwXrKP5umGO9KKN5fdCnP33A55cCzZdnnykW/iywP86wUwlmarb5XG42nWN6izJ1NIPWAjrS1rr/7aNrQjGnrLq+BN3volHcb0Vxj01cF/owkwTeqElTDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95rXWtzdd23QQQC6m/p5cz9v88MdKaavrsnuHlHJLb0=;
 b=hd/JhqWN98NPnioY7Q2iVwHMBH2UCqhayhON0dpWQJratPlvkrseBbAm8O0kbTe5Z+r0u0CnXSXyIChEF5vDbzwnOAY3sXTtgB5JmAv2CNF3E1odirJsoSQeQbsZBVA6umcRkUdcTusTiY/1tWolWgZPqFlr/FPXBBTwomwovG43F/wGeN2ia+nXDS3pPsAhfjNYUf2DuZPhd002mQJoQ0r1ewSA521K1vOsk5eTp6mUG9r73eVQg2Qt3+hHANMvh6CkOenAWP4h+3LsIZBcysXJVaVApS9r7DKTOvJEyS1RZB1hwJQkEnMowt6njcR5uC4s1Wiqr+Ms5EbUrjdfWw==
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
Thread-Index:
 AQHZlZHqSKW+Shm580CRlUjcCTH7qK96p2iAgAAAjkCAAAV4gIAAAhyAgAAFe4CAAALHYIAABcIAgAAChLCAAHFxgIAAHa6ggABpWICAAHwV4IAACZWAgAAiwLA=
Date: Mon, 5 Jun 2023 16:04:57 +0000
Message-ID:
 <PH0PR12MB5481CEB3A34AAB49A282F2A8DC4DA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230604094535-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481443CD383D9BFA0369151DC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230604101351-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548139ACEC00E7CA6D988182DC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230604105027-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B721C34D85D63FCC1F3DDC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230604174224-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481DABA25CA36A5460B13E5DC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230605014539-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C14D65D5E10CD23A9F67DC4DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230605092859-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230605092859-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM4PR12MB8452:EE_
x-ms-office365-filtering-correlation-id: cb027d6a-f81c-42f2-c4c8-08db65de9b93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Gnyy22gBZLjy3M4fz7lKhthhXh0qFbo/FXe3ispOH+RMtf+ltT3Hen2MBT9CwRNXALESSrq5CAnnilS2Kh+vBKtyj6oZy4/Rlu84JqlD312mu/r01q4OWAMrMWhr9JIWmwcHNzmZ+21IGz1Bny4hYM2c9hwyIscvNVwnjcuadU7elz3ZS9NH3ZN1V1Ocdfbg8t5/c0+A4vri5oI1W+NCqRODH88A4YDKjElYU1031ZnB9cv0VIfas/S8/RSATDDpORzm78OZcIIionfLMomi7/+ZIdEVYrqG8bkMSBcAfPtQ5CXJ+YrG186X3Pc0Y+eW2xXV/GpQKAsHeEI29pJVJ0nSAt7uA/n8inh7WP097zKIHjm6TXuNfoQnwrOKc+Lt9IY1T2sAQPhHkPQegbYKx1D2YsItMUdcWYjFnwmOifHn4H8T/b+D9ArzML42aWQtOWdPIcaAHWjsoDNNVauaUO8ozlwNQjGR+CS37jks4CtYiSP5eSLHGzGXiuYQbnSnmtIi/40Vt82HDZ2UdyTCAMrfg6p/J8/tIJcmT7e5f6wBbUbfq9FTyswHEAOqT/pCWP8hRv9D24LcstmGI+j1zub/DLmKdVsXM0mV9Hq4Ka5RMh2pa6ttLbKKc1Uo+lER
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(451199021)(83380400001)(54906003)(33656002)(55016003)(478600001)(8676002)(8936002)(41300700001)(38070700005)(316002)(66946007)(76116006)(66446008)(52536014)(66556008)(64756008)(66476007)(122000001)(5660300002)(38100700002)(6916009)(86362001)(45080400002)(4326008)(7696005)(71200400001)(2906002)(107886003)(186003)(9686003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?eHHqesEupbIMw1M4esPsYizVBTiF9vG70QawD4IEtYtvDqby4kwszwDDPsRz?=
 =?us-ascii?Q?u6GDfH/RsihEoJXGUDgqGaHQUNm/2X2lXwVE91Ih28jgXKkQrxWVGLiOnLn4?=
 =?us-ascii?Q?0+5qdySqmN7BK9hsgk7WwMkumrSt6Oy+Nzs7mLSDhnMZ2N4lN32YZg/VNtMC?=
 =?us-ascii?Q?HBZd/3YhBwXOenZgivJJUXZeEMDumQKZBPBSKsSFNtlf9VXmpiWnoXFR6TSp?=
 =?us-ascii?Q?TBJbHAQx1qNL3hJz6D12uDx8VdUT6Nc57f1wAMoN5CxLC/jSn0Vxblh0XnPb?=
 =?us-ascii?Q?TJtTe/x3FMuJFHbk39iamP4zxSvyETpi5u2mkZj1N4W8xo1+8pEkEmr4B38B?=
 =?us-ascii?Q?upTwYk5dyvzqwH59QgRAJNGKH7ydPoN4RFRuO8u9MOnQ9r3bEuF4wlqVYQMA?=
 =?us-ascii?Q?F7+5huJQFrfP243gf9mPsx3krEM0q+fW0PsEi159+nFg4A50qe7jTPVHVVFM?=
 =?us-ascii?Q?70Y0cUYHA88XgvM2/xDhE/N9CX0rENbog6BUZOJ3RP+0uglGnUktCZ8oxOOs?=
 =?us-ascii?Q?yHtJBmqZIc0D7Z9MmeZaAEGd1xyLlacGk47Rn9nR3Cs4YdEV7VXiSDirXcwq?=
 =?us-ascii?Q?us7wu9fYz/rxguOFVCDbnFc2wcroJr8v/jo9n/iw638dLu6KK9BIfIjv8rOJ?=
 =?us-ascii?Q?3HKyfoPt/LXu/nt1EiZ/MuprjDHWaiAmlJUqWFDtcXllX6aPmeVyXUmNhvbT?=
 =?us-ascii?Q?2ICi7p/LTdO0aHuS9MqSubRZDCQFd3VgOLqCaOC+Lkmvkwk7mRWt8BOL0ZEn?=
 =?us-ascii?Q?LCTfiY2Uog1TIB7jzqe7B7izmDOnvrkdZjHeAXAQx1C1wt8BuptlGL0nu72s?=
 =?us-ascii?Q?fW39O5zOooBu245M7kwIHhPyk9VXIn7LVMt6oW59pljBqsHooH68yoZt6JQ+?=
 =?us-ascii?Q?V5p7zWrg2syM1Ffd8JZNmMInm+SoA4Tkc+B/P6yhhoNcsSsJI+SgX9Yvnh6Q?=
 =?us-ascii?Q?sF+FOet2n+E7UO6/7b7XGTAiyYEPHBN3rEKnu8cP51Vre1dSLw1HhvWsvB7+?=
 =?us-ascii?Q?9514/O+rrxiQntSUtGLim81i7XpMPyzrHgQYsoVa5YMAZNR1lun73ZwVWvBW?=
 =?us-ascii?Q?BQ6wo+LZJhQroRsCkAO+Hb50ZB6F6qQyfUe1sQBnwqdHg9HzJ+JonH7VFkhE?=
 =?us-ascii?Q?0rtZQq7HY6RyESlYqwnqa2Ekkwr2aA7e5suTt+9Rs79/EX74YXEfJySYTDPY?=
 =?us-ascii?Q?zov3M73f5IsMkbiG65HDx7AZ6Gvi+0omRwaMlQe6yyiOhXzexpNNIZdBcdUN?=
 =?us-ascii?Q?c27cEyGBXlmR2z5Rdq1t3hMwbGg1s+mx7UVb0ymSmp/Av6LBRe7SGmi/9y26?=
 =?us-ascii?Q?0J0lAoIMIx5GTpNdLiBxMQhRnpZ35PFZz+kmiux1/z7f/2eRTae0ECtvi4tF?=
 =?us-ascii?Q?sZOUN+6LyKyMCA7CdntB4nqZm1nKHRMfy/u8wnBlgHKdjIok7d05ome9DxtD?=
 =?us-ascii?Q?A9RYqNZH/3AZPsJqnzzxbMjPTeBeQib+xlBQuyopwWegSP3s8Jd5wpugdEui?=
 =?us-ascii?Q?aB471BuxAjOIsNpkW7eHsuBQu3PwlVbMUFr8x/Q8qMQao0+/wttmQOtCZYGt?=
 =?us-ascii?Q?78AGdM4mtJaHA3GS+9HLPHFKmPFRGJwh1EkI3In+AX/TohBABVktxIcVEBBG?=
 =?us-ascii?Q?uJ3i6H9y+KlH62J3jJCKCvI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb027d6a-f81c-42f2-c4c8-08db65de9b93
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2023 16:04:57.0302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lW4fGlor8V7W2PYd/huJFAimeV782YTylfOF0OIQG375RpiSXdejVl47JMZu4qshQNOToP9Feb0h5gMvTeC2FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8452
Subject: [virtio-dev] RE: [PATCH v3 0/3] transport-pci: Introduce legacy registers access
 using AQ


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Monday, June 5, 2023 9:50 AM

> > Can you explain the motivation of : why querying notification offset vi=
a the
> group member PF is a problem, if there is."
>=20
> I tried already, I can repeat if you like:
>=20
> So, I am thinking of a model of using a tiny stub driver for the member.
This is what is proposed here.

> Control path driver is bigger as it operates AQ command, that would be th=
e
> owner driver.  E.g. for PCI this driver needs to map BAR offsets.
The bar belongs to the PCI VF and hence BAR mapping will be done by the VF =
tiny stub driver, aka vfio vf driver in this proposal.
And control path driver provides the AQ facility to issue the commands for =
register read/write.

> Then it handles all data path for this member: driver and device notifica=
tions.
> It is clean and easy on all systems assuming you know offsets at device p=
robe.
> But getting it in software from another driver (owner driver) is AFAIK tr=
icky on
> some systems.
>=20
We can assume that systems will eventually improve as multiple OS are impro=
ving one way or another.

> Generally solutions can be found, they can be more or less robust, and if
> systems designers have to overcome obstacles in implementing virtio they =
will
> just go to a competing interface as opposed to jump through hoops and wor=
k on
> extending either the OS or the virtio spec.
>=20

> Yes I know your sales department tells you there's no demand for this fea=
ture
> on anything that is not linux/x86 and maybe arm, and maybe this means the=
re
> won't ever be either, but let's just not raise this again can we? E.g. th=
ere was
> some interest from microsoft at some point, I think there was a reorg and=
 that
> project died but hey you never know.
> Anyway, you asked I am trying to answer.
>=20
It is not the sales department. MS has zero virtio tc presence to show the =
interest.
MS has zero inbox driver to my knowledge without current feature.
Hence, the absence shows lack of interest and hence building something for =
them with pessimism that they will not extend is not right IMHO.

> The cleanest way is just doing things consistently through one device.
I would surely do that for all future devices which will be self-contained.
The cost of doing that for legacy is not worth the efforts.
And since we agree that read/write 4 commands are OK on the AQ, the 5th com=
mand is no exception to it.

We are not at the point of questioning the existence of 4 commands itself o=
n AQ.

> In this case for data path it has to be the VF, so let's just make this p=
art simple
> and self contained.
>=20
So data path is on the VF to do driver notifications by the tiny stub vfio =
vf driver.
It queries the PF driver when it wants to use AQ facility.

>=20
> > I don't see a problem with AQ that covers VF,SF/SIOV for legacy.
> >
> > Proposed AQ command is cheap and covers both VF, SF/SIOV.
>=20
> Well for SIOV BAR has to be the owner BAR. This was exactly the reason I =
asked
> for this. If it's not to be I think this is my second preference:
> no new command at all, and SIOV will come up with its own.

So a AQ notify query command services both VF and PF.
It always returns the BAR number for the own.
A PF would have delegated the window in the PF BAR to the SF/SIOV.
And hence, this command is just fine like rest of the 4 commands.

(Linux already has SF accessing the PF dedicated BAR for more than 2 years =
for non virtio device).

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

