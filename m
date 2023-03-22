Return-Path: <virtio-dev-return-11721-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D44C6FD1C
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 17:08:07 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8917168466
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 17:08:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7E8BF986463
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 17:08:06 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 713C898644E; Wed, 22 Mar 2023 17:08:06 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 59A9C986450;
	Wed, 22 Mar 2023 17:07:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n6cN5yTcl4sWoxfnXgQzyho2L8qNTbDu8ORDmKzvxfvRV5taa4PbkwPqfHX1AViF5ja8/D8wUWne5dTKiGJ6v7I8BvoOySap8V5/rHWU/3EkUWr2VoT7eDDXGo90xL+e5TQiJ1QjGj8bOqP+Na4QOJLo5Vs4FeAhhbYAnZyVfN6BOVhl6aCvutTszlctM5OKSUKWk4dinvJq1kFvrd5QCqgKmokNGlQUmI41utFVvuhoe3urrsxvmQv+sfSz4tyQySupD2L21BA6M7PqcNEQMh/+4fnakkFflhZBcjSV7VbdlNba64/52h3Un/A+qLCvm+/3gDzfWhF7MhItvHHEVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6n2i4jFLvCXT2nllAGMvOmVMtWiIn32vfZ59wPryXiY=;
 b=Sx2jWfL67/AndSJdNYv+yh4eV7IXGzvcDAxLAbLaK+1Wvy2app39xJQqiNqD+eNuUatnyjnWOiwmv27t5EO8k+krm5MMvKnlulDXIF08N+V4waHUDR9jORZboUn09P8eQ0TSThJvdMJaYTxaDB4DvyvGP0aYMcjyHOVz4znjKS/RY3wEDMBzfF9pONSBCIrmu7Ly87AnX4pTplP6yioq/16puFPwIXK5bgOuzoZhD02w3R8cqr8C9cD0YhqMrYhUKb/PRfCeXbKbMJAoqU1zOP9IhVbdpCMAmqQk2GvdlqULbrwq2N4FDyZUmJo425EYZKbPG1YZPfy/VFN/5c2O9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v3 8/8] virtio-net: Describe RSS using receive queue
 handle
Thread-Index: AQHZXEBhAOCcFxUsWUm/MA+nPP3zI68FzRqAgABGj4CAABWFgIAA3ubA
Date: Wed, 22 Mar 2023 17:07:51 +0000
Message-ID:
 <PH0PR12MB548118C2FB6C986D945397CCDC869@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230321215834.225856-1-parav@nvidia.com>
 <20230321215834.225856-9-parav@nvidia.com>
 <20230321180052-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481DD9C8A5D0B1B14A3B184DC869@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230321233616-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230321233616-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM4PR12MB6253:EE_
x-ms-office365-filtering-correlation-id: 9c978afc-4145-41df-ae7c-08db2af7f868
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ZGbS+W3Q/TqytL2p5198QjfhhvMTSydh+9g+5RueEJo1YCXOj3ZZ03Jee4r1K5d+YqppkM5GcSfgy0RXeWz/vxO7Q6edFEMdQ2VcH0D/+GMK8R8oYOuEXDvzdAsCmclApj0g0oXV2zIVV0cwVw8gX3/Gp518h95oOHezlVwz2Wrm1Th+8fPsDBEhmfD5MhE6RSz/4Dk5BKRlyE91OljNissQ/TQjOQll0MTjekJl7hvyr/xY3ZD3n4n1TQOaWmJJw321f43zSvX4Su0VPgalFQ42CIXQWev5UDw1OenvD86NtXVXUXWk94QYPqwsIUeAf0jpM8ePeL4AhqwdUGC9AC81Uk76BzggjazugJPjRqn73m30x1dsZD5lCig0Llp3p2q0TyI7HMjBiYoh2lhLYzMgCqhCsQBOUYUrP1rM0uzwWAzwhJ/ZiP4xqQ6l9V6C9ZM/BbeLSfm0sysowj+cFYDVtTut0/X90jB0fsXfKNkNd82RgSl25a80cTHnNBg6rx4CNHeADrhP6cwB7ZCv0gWOz2j3owtKav+jmWPEK9I6LPnfkzTOTeynT0vWvJAXADL29DIE/yS7C/YtteYWPg6+D9Tv6uUn5Vs1dPLZlmYz/RB6kfT1rj0PiDlJo0LcEbNeY5WU+ZZKnhu6T5vKIFLcjKeicmRsfN+2OOyY80Sl09qtzEIKJYcSNoIw6bfug3Pb8B23XiEkO70rcKXswA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(451199018)(7696005)(41300700001)(71200400001)(186003)(107886003)(4326008)(478600001)(316002)(8676002)(64756008)(6916009)(66946007)(66556008)(66476007)(66446008)(76116006)(9686003)(6506007)(26005)(54906003)(52536014)(8936002)(5660300002)(38100700002)(2906002)(122000001)(55016003)(38070700005)(86362001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Jtapb1eF4AGXv2rKsS1w1UJL5/5s7SkquHh5N0HnRXwjm1+EMmBbug+nES3Y?=
 =?us-ascii?Q?PGkrG6eyCP6nbXUfAgD2y8qierBI7iIno/RiuxoM4kDQv5L5TP+5izyuCXtv?=
 =?us-ascii?Q?LCCwLSJaAyM+K4vY4JkqBYauFj8yEUUu2ugY0c5JS6a947buGFZe2Z4466s6?=
 =?us-ascii?Q?Fq463H8bVRPcRdqntf0HMzMVCWX7AQ+WdYz7rj76c5BV02lb2HwPcVDxuPVn?=
 =?us-ascii?Q?GPvBD5aYKEa7ZCw2Cwj2gDfLiWzC/UrLF13YjXZTrcqWgz9zSd1ERNi+xKv+?=
 =?us-ascii?Q?pQ8W05uQypGUA0znmGbcesBQYTKPyWv/ggsAbr+6Q8mjyeSQxepQxz9OWzR2?=
 =?us-ascii?Q?EwdMfsU/f97k1GQa2YPND22O0MKeZx8WgBFsiPqVvD3jpBIYQyi5uo+PI0HU?=
 =?us-ascii?Q?Q+DLKVmNDIe0itYjrCYAROCjAdwAVJKhn9yiKSzxEa5Z6RPNK2RmkqKe+WyD?=
 =?us-ascii?Q?yu6gjWwwHgYiEFKDcHEXMcb4XctBHcEegX+nGXH+oP/6F2vJBBDsiS+egWmJ?=
 =?us-ascii?Q?UkOlWzSR926Np85kwib2w/Sjdeginxnko7u0YAJ39Av4abfM3AVQX1tGNHtJ?=
 =?us-ascii?Q?Nr5y76v2EYI1FQWt8itwA415UIfha4ZouU0UzYGDq9JgUis7mhmGrZJZGU6D?=
 =?us-ascii?Q?3DlDP2uvmKIceMwZ4zwuOwpdY35VGGLJskdbW9PJK15wfF7SbN4tLccx2vZh?=
 =?us-ascii?Q?E921jZ7AghXrX8VJGxkBZQypZt35YSfS7c+dczsafiLqk3oVwifLFFpB0v82?=
 =?us-ascii?Q?W8ODj8xyMDOTcMV6dyERF+jF7D31jmZbsw23QerailVJYyuepTANTpH9iNd+?=
 =?us-ascii?Q?ueEA9czrKhX7R8lJAwqJuM1doWeg7AlNqRaSUctIUQmJ7DgHEDyJjeH8fYtV?=
 =?us-ascii?Q?h2fIdBtULKo7liDLwwsz0hpCP11T5vWvPx/RN4XGpyeVp4QL3DhXOVqORjX7?=
 =?us-ascii?Q?shtMDpwDJgsI8i/U14Bmjz8AyS6A3hcR3aWM9VBjNIDUMgQumWTOuh1PM+9n?=
 =?us-ascii?Q?Y3sS0rFQuskLNWC+6Cr25VoFlnZ7e1Gax0+rS+y8lfulH/UYaK+YQhVbgZRb?=
 =?us-ascii?Q?IRQv+af/m9Xh9zXkvqq1zX0KYGzqUa2Li57Ud/XAWFYTiKDfEcFOFETGMhVc?=
 =?us-ascii?Q?wva+QCr0D9eXZKqguoEjXDicZSGsmP2h3YCqKWXcm+LavJfhtK4l+S3bysvr?=
 =?us-ascii?Q?r2WVvgxeIFy93eTV6pHKZgUu17ybyaOVpTX1hquKSv7o76W3z1QOc8bVqLWp?=
 =?us-ascii?Q?jLl2eIjAiBEjCFm/iX5GcU6+5gUlyvjVl7ccJIaluxtA2zy1CgXllUsYpQqM?=
 =?us-ascii?Q?RO4Z6+Hjii98mZM8FdVwqrjRT4ae1kw53QZsgHeylD1cbbiQA4Ao7zke1lu+?=
 =?us-ascii?Q?MS+6tA53AYuYEwFIBqwhAnUp3/yYLOyt/rd+psntZXOFqfMgDv70Mmbog4Wm?=
 =?us-ascii?Q?qY6ObFfW8Hw3yTq3FAkFMY9iJfvOKtKboWFKNrT59kFGyLivQ03rlaO5KeQL?=
 =?us-ascii?Q?mm/OiRXl8lBnNAS0b7csHadGrXFpTVovl9gkoNPa1UlRvqM9AYZqtCu8Rk49?=
 =?us-ascii?Q?dPmKUWwZTE8QJvlN8IQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c978afc-4145-41df-ae7c-08db2af7f868
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 17:07:51.5330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wZI2IOjj5UPnc5rlCuKV2DxqGqDYBEEQEF+sQ1NQO+9HBcuSRxNiYhG4Xq5q79TrnL6K7lyyYzoVhfs1ov/SSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6253
Subject: [virtio-dev] RE: [PATCH v3 8/8] virtio-net: Describe RSS using receive queue
 handle


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, March 21, 2023 11:46 PM
> >
> > > And it's still kind of complex and non-standard. E.g. what does
> > > \begin{lstlisting}
> > > le16 rq_handle;
> > > \end{lstlisting}
> > > mean exactly? Apparently nothing ...
> > >
> > Why nothing, it is referenced further down.
> > Did you suggest moving before using it?
> > It was just fine to provide a forward reference.
>=20
> because it does not say anything about the contents or the format. just s=
ome
> kind of integer.
>=20
Because it is an integer there is no need of a special format.
It does say about the content very clearly =3D vqn / 2;
But more below.

> > > I feel what we keep there is really the virtqueue number itself.
> > > Just stored in this strage format.
> > >
> > > And all this talk about handles kind of seems to add yet another term=
 to
> learn.
> > > Where in fact all it is, is just a different way to store vqn.
> > >
> > > So my idea was this: we say something like:
> > >
> > >
> > > \field{unclassified_queue} contains the virtqueue number of the
> > > receive queue to place unclassified packets in.
> > > \field{indirection_table} contains an array of virtqueue numbers of
> > > receive queues.
> > >
> > Above two lines are clearly confusing where virtqueue number describe i=
n
> rest of the spec and above doesn't align to same notion.
>=20
> That's true.
>=20
> > So better to say field A contains the rq_handle and
> >
> > struct rq_handle {
> > 	le16 vqn_16_1: 15;
> > 	le16 reserved : 1;
> > };
>=20
>=20
>=20
> >
> > > Both \field{unclassified_queue} and \field{indirection_table} use
> > > the following format for the virtqueue numbers:
> > > \begin{lstlisting}
> > > struct rss_virtqueue_number {
> > It is really not any superior in term of cost of learning.
> >
> > > 	le16 vqn_16_1 : 15; /* Bits 16 to 1 of the virtqueue number */
> > > 	le16 reserved : 1; /* Set to 0 */
> > I like the structure and reserved bit that enables to claim one bit for=
 some
> unknown future use.
> > > }
> > > \end{lstlisting}
> > > for example, a value of 3 corresponds to virtqueue number 6 and maps
> > > to receiveq4.
> > >
> > >
> > >
> > > and then everywhere else we just say it keeps a vq number, we
> > > already explained it is using this format once no need to repeat that=
.
> > >
> > I just prefer to rename it to rq_handle ( or at least other than virtqu=
eue
> number) to distinguish it from rest of the virtqueue number.
>=20
> Well first of all I really want to make it clear it's specific to RSS at =
least for now.
> So let's prefix with rss_.
Yes, rss_ prefix is good.

> Maybe I'm wrong but I feel using up a completely new term for something v=
ery
> specific to RSS is a waste.
> We won't be able to use handle for something else without confusion.
> So how about just
>=20
> 	struct rss_rq {
> 		le16 vqn_16_1 : 15; /* Bits 16 to 1 of the virtqueue number */
> 		le16 reserved : 1; /* Set to 0 */
> 	};
Rq is usually an object and here we want to just refer to its id/vqn/handle=
.

Hence, I prefer rss_rq_handle {} or rss_rq_id{} for the structure name.
WDYT?


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

