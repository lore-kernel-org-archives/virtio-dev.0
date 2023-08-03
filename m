Return-Path: <virtio-dev-return-13446-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E11C04FE0
	for <virtio-dev@archiver.kernel.org>; Thu,  3 Aug 2023 11:21:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D6C28C6238
	for <virtio-dev@archiver.kernel.org>; Thu,  3 Aug 2023 11:21:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CFCB6986863
	for <virtio-dev@archiver.kernel.org>; Thu,  3 Aug 2023 11:21:19 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C3F5E9866DF; Thu,  3 Aug 2023 11:21:19 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AC5579866B1;
	Thu,  3 Aug 2023 11:21:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bGsj35HPdej817NIvghlbhKJdA0tbihH6mjmYTGkQf8o/QVtt8mjHJk+Ifq3C3fyn26r5FmIrpZIMkzlX4pDn3ZYOWRuuHE/38h37haNN6UiQqpoUsCdeBTDaHwt6Y+ECHW2+EG+ifjY2OI2mWyH7Z+6CRjUjKLDqbYrRFLJXhsBrGLqH9K/fXDTpERXdEYfYa6awzrmoP2db4EREpuUMdmeM5IzPuTVX2/yRo9u58z9YGpeeorIbcxCswultfblu0TRJNICowjWDsTXbKOEH/r94g6K/73osEVqxflL1DZFxoN1CfDLsRFkBiH8HiNeIMysWH5+rYPCBE65E4Hatg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ISHIw1cVA+xiS/cwICwLdKEHu6ksYenhsyLNFJqLEv8=;
 b=en4laFPub/yOCdPa4mMHjsDgVYf7CPSwip3NC5vDezgonTo+i6SWUblrl3WvGE93CHahteF1ftwkKrvUkDXsJ19Py3czt3It9SHd6sNtTS9G3WGnZ/Z/q0CxkE1ZpuVn5MZPZdrk3Vxww2FvQeXA5TSVTGMHmDjFrVICgIwd0T4EZ39A2I9hchsMntQoiX5vOU2+2zeeihffjm2H4hghTXKD9LRovDejgbaAt62EQVpyJVNhZHtPRDuMHTwvXJMbItuHXkW3uaLIWzUA/fjn/xIDH4pCOi++HmZeV7Q/hDBjA3rRNP9mvw1XRzpHLgcFyhluyvUqDLjP/XBwZ8Hq8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "Michael S. Tsirkin"
	<mst@redhat.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>
Thread-Topic: RE: RE: [RFC] virtio-net: support access and control the member
 devices
Thread-Index: AQHZxeT2Q5D2+syVdECqHrje6hzlHq/YW5SQgAANlICAAAC1wIAAAfyAgAAA5HA=
Date: Thu, 3 Aug 2023 11:21:08 +0000
Message-ID:
 <PH0PR12MB5481940B21B24FF817891D34DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230803083150.46745-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481B976E62998B8B61267C8DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691060755.2124963-3-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB54814C7410C51E08348B14A4DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691061333.287353-4-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1691061333.287353-4-xuanzhuo@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SN7PR12MB8147:EE_
x-ms-office365-filtering-correlation-id: 3670657b-ed86-48dc-d438-08db9413bc59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 pFi/Jal3dpw0vKMv0Z73Szkf4SNjpECWH/oZvwkgwc0QisyMuCmBovnFg703SnzBtrIoIILVwNTohD7jBIApRqWZpEX4geHD0GVOlGoFYYKsoGIQL8h4oavzCndJapCKw7QnerlZmoZU7amLRn3xpSoxweBTpxTc6/XiCuUeQUVEMLlowlaicnPVaDYIq4PMr6QGtNQdJc4MRtQg9j1s30Aa21dnggPnu00f8sIfF72ePEx7IWyX1XZRLsQtjJjcYRYJI/2IX9x2g9JcpJZxshRvKC1mvMMpXMKsPdbQV0M/aGYNCNtbnEgo3rUnkpxoT5Nb1QgXM2e7YmOSyjlm/CxenJtBzcOYIcv9YAuxcx5yhg2SNdsfQ23Jh57FfaAP6Ious3LWBg+RZ2Lt4YDhxkf411pvFd0yelXi2c41r5LDqrXoO892tehf5YHXUjTVKTZqLy3nB12d0iu3RHt9wbtvcS0+sDgI5Ryp05ZhHLQOVeHvWETZGLr8xlfL/dIPI/p99ojcgL1vIkA+PYHOF7LHINQJq5j3PAY/eTewOasO4auV9VSksbVLd6EdxPyxktcGJSv5Jq7Q5lsqV+z5CMkU12zUpj0i7MD292PZta3jXMxvTAHB/TAdWxYPa6XG
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(39860400002)(376002)(366004)(451199021)(41300700001)(66476007)(52536014)(66946007)(66556008)(6916009)(5660300002)(4326008)(76116006)(66446008)(64756008)(54906003)(38070700005)(38100700002)(2906002)(33656002)(478600001)(86362001)(316002)(71200400001)(8676002)(8936002)(122000001)(9686003)(26005)(7696005)(6506007)(186003)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GEVKWA8C4lx2CCr5Uc1AycfcxoFg5qLP9RZPHYmGxai6Veg55cLhJlDBhCrt?=
 =?us-ascii?Q?bYwM1iIbpJS2WODlly131MZtctBvgpTAZj5JrBySQpqsaJBBU7Eu12+z8wcl?=
 =?us-ascii?Q?y0TsHaEpTonoccjvPLXTaIYwK+kDaWz5Dmleyrm+fNU/X7PRMajD1I4iV3nc?=
 =?us-ascii?Q?eBJtVXfvlMcxK9Ez8EDv3jUWJ91Ij6PZ+JmI4oF8cOsG/pm3gaP8qWGTk9Lr?=
 =?us-ascii?Q?UlwWbIz0foTy+7W+Dy04X3u+boKMjm5F8H0G0AWZFODsJmpahCQsqRItdXgH?=
 =?us-ascii?Q?HJS3ViQ95Gnka8L5fYkRp+QrdPhAUoxqDIyh5gw7UesXxOLGLHdkmU+k/E27?=
 =?us-ascii?Q?1Upzffmghj0sKrRtF5QbJS6LN6lpsRZ/RdRjz2FEKNIhF1V1mJQBQ3fJ91Qf?=
 =?us-ascii?Q?84o2hNZPMY9xtAGspbqdGo1KKxHav4lbPr1oh9K7tRYCcs4GUTpEhTgzDPm/?=
 =?us-ascii?Q?h8G1TCx1kjdiEpUeCVI9hDIqW4elypoIjrN7JOlBKUw3k/m4bHvHYQvhRn6A?=
 =?us-ascii?Q?fcpZ71c+QTYK+aEBZ/GZt5dne3w7mIbWARznMtITpYygEHQguOhEVs3O4LTV?=
 =?us-ascii?Q?lulABW9ZpfMKBymtd2sJTJgTWXTo24xmM4tkrVaBscxHW/1ibBDfWJtKb4M3?=
 =?us-ascii?Q?0eyeaUs4KIWEX5Bnu4zt1ybYdR5IpuWao/FaKVkTB8FgHhJyzjt/vMz1pVxl?=
 =?us-ascii?Q?wWuSz3X1wfQzgn7r6ZLvGoJ+L6uoNLFI7dBFXg7s0qjZBa03aif7kg6yhjtb?=
 =?us-ascii?Q?K4LDR9/fAtXqV43y2e95TvZj7siBlb6Mt1+nN1RphuGoOkOZfVA4wFGM3MtP?=
 =?us-ascii?Q?x8CTK/BAFpeartjWJ9PqFntV+HFfGKbYEELocPCj9gEZZikZ6O+twVwxEWPZ?=
 =?us-ascii?Q?bk9U4gamoQL0bBwxns6SjmOD8h4vFhO1tpzHhN4MyyaI+smHKRg+NgrhAK1P?=
 =?us-ascii?Q?osR1rkk7M1Tpl/GAvtLysNI4gyeuyf3g/GSuSZDBr38vArWyUCSBmX6+Y7of?=
 =?us-ascii?Q?je2Hh0Nw9u+BCbglNLMExAxXrHNHtBi+bvQb5JejMV3zv1J+mqmsBkoU3n60?=
 =?us-ascii?Q?vXEm+R06H9VJ2L+rI8rHb2dtqdDawRLx7TImQ23/HocqKtaZaa11L/Bk+Lll?=
 =?us-ascii?Q?oPGFFEpF2UOQWjOPIcQaGQjUWYoHEhivzmui9J+P4NdW44B34SdKpX8MD87w?=
 =?us-ascii?Q?R3r4H/mTsRWjRtYsBuzW4ZYnEVu8+mahQAxM5E4G94WpstO1NI7fVxbEHOsl?=
 =?us-ascii?Q?P39/JnB75zlJ7xR7iQuP80nFE9sQ8ScBqF1HNJB4hvxSeprRIY2UOtLagUnC?=
 =?us-ascii?Q?xoq2o5uFDgux654TNromgqFMgct99Zau4bS9p2Wm8v4eEEJDTVUWyZbowg1Q?=
 =?us-ascii?Q?JeREY3TPsCPltOQM+CnoNi774q7vU3O4adbcyhwFXObpg/1arbdt4YalHrqR?=
 =?us-ascii?Q?xhhSXgn1b0Y6UFfgAQ/EBpJpFD6LBbTfr+9T+YeUyR3h2ZnZIak4b3UO2dp4?=
 =?us-ascii?Q?QDCA/LLLpFCLJ09Du7v6InAGAlD/nKRsJfHv5oNg5yO9WyO2hlMqsFElAC5v?=
 =?us-ascii?Q?0dOB5UDC9AUYEgQmapc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3670657b-ed86-48dc-d438-08db9413bc59
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 11:21:08.8144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9ABJcyFvQppzKi+jL1gAV22rqDU5tT3NUcC78XVu9N1jcM6GqJaICI/W2MqrIF4BCGCg6jlA7BZx6g+iOHRsWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8147
Subject: [virtio-dev] RE: RE: RE: [RFC] virtio-net: support access and control the member
 devices


> From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Sent: Thursday, August 3, 2023 4:46 PM
>=20
> On Thu, 3 Aug 2023 11:13:28 +0000, Parav Pandit <parav@nvidia.com> wrote:
> >
> > > From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > Sent: Thursday, August 3, 2023 4:36 PM
> >
> >
> > >
> > > OK.
> > >
> > >
> > > >
> > > > > +        u8 mac[6];
> > > > > +        le16 status;
> > > > > +        le16 max_virtqueue_pairs;
> > > > > +        le16 mtu;
> > > > > +        le32 speed;
> > > > > +        u8 duplex;
> > > >
> > > > We should above split constant config space fields and below run
> > > > time fields
> > > meant for debug purpose.
> > > > We are working on the member device migration proposal and below
> > > > fields
> > > belong to "device context" should be available through such separate
> command.
> > > > But if you do it before, please cover the whole device state and
> > > > we will be
> > > able to reuse for multiple use-cases.
> > >
> > >
> > > I am not sure I got fully.
> > >
> > > I will try.
> >
> > Something like below.
> >
> > struct virtio_field {
> > 	le32 type;	/* contains the value of enum virtio_dev_field_type */
> > 	le32 size;	/* size of the data field in bytes */
> > 	u8 data[];
> > };
> >
> > enum virtio_dev_field_type {
> >         VIRTIO_DEV_PCI_COMMON_CFG, 	/*  struct
> virtio_dev_common_cfg */
> >         VIRTIO_DEV_CFG_SPACE,	/* config space fields, for net  struct
> virtio_net_config etc */
> >         VIRTIO_DEV_QUEUE_CFG,	/* struct virtio_dev_q_cfg */
> > };
> >
> > In your use case, it is VIRTIO_DEV_CFG_SPACE, just blob of data bytes.
>=20
>=20
> That is ok for me.
>=20
> My question is what is ctx? How do we decide what to put in ctx? How do w=
e
> define ctx?

In the live migration use case flow, ctx is collection of all the device in=
formation.
I only listed 3 above for simplicity of our discussion.
In specific config space query, like your example,=20
The owner driver asks for specific piece of the context to query by supplyi=
ng the bitmap for above enum.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

