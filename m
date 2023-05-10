Return-Path: <virtio-dev-return-12625-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E4F6C77B7D
	for <virtio-dev@archiver.kernel.org>; Wed, 10 May 2023 14:30:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 38A932B36D
	for <virtio-dev@archiver.kernel.org>; Wed, 10 May 2023 14:30:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3182C9865EB
	for <virtio-dev@archiver.kernel.org>; Wed, 10 May 2023 14:30:32 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 23844986591; Wed, 10 May 2023 14:30:32 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0E1A2986590;
	Wed, 10 May 2023 14:30:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FS9uTPlzHj5UYE0gp+6Tt4iD1tRN0vwJ5Vh015xaXTvWfAohOPaOHZPhAH+8Zpy83XDJk/w0oshCElan58OLDUaXlTFcBQBdP3Iy0qjrJM+f4VCKG6VKEhpBKyL4DGdkn2u7NbAPMXUg0bNjcKupBR+GnvLqs8HZ7FI945lWrY3Ur4uBVH1cEq8aEGkH79RotABhXTRl+INXMG+vpYGdDCpi3fHhJNeDTRbV93JI9HhRtKPb46xVhgjg1i/Wjc+R7QeX0pdfMYnt0pJBek1jb4tfYcBTwu/zJADZzIs+WjBgU0fA7p5GGwHwmRITIdMQn2ZhFigLQIeCCxWM8EYrog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7zQAlyP0GUSMJ86gED+LhWD7piwJXbSRoJ/UbFeNHPs=;
 b=lRDSr5DAsn0EkpdXzA3IlPcjhZJ0pc7Oofhrf+8bXnIfMFIM2LTfkB2ganbAN2zEox83Kia3A4Lipg8lIIQ6I61B5V3amLO7AoVA57UL7WB+OXaNkuBGB3uezw6EgdzDn1X1YezSfm+Oc2ded+HsBcEdwoZHNNIOSuA7bxTe8iZa9vvsMyJa35r5qOduGvPypVCHtbjJYuVIEfif4GcEgD3+WvfqflNTmNSJKY6M70Z0fbivVDTBhW/osBxd/7q1FW044/IXENifSKCWgIa+TwznYibwhDM5R0cHrojUijVEE7L17eYR+BaCCdoUQrC2wib42uUre4z2loTg12sG2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Date: Wed, 10 May 2023 16:30:18 +0200
From: Jiri Pirko <jiri@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
	stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com,
	hang.yuan@intel.com, virtio@lists.oasis-open.org,
	Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
	Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <ZFuqesg6YUSJi4dd@nanopsycho>
References: <cover.1683301091.git.mst@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1683301091.git.mst@redhat.com>
X-ClientProxiedBy: FR3P281CA0081.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::11) To MN0PR12MB5979.namprd12.prod.outlook.com
 (2603:10b6:208:37e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5979:EE_|MW4PR12MB7288:EE_
X-MS-Office365-Filtering-Correlation-Id: 24850252-1544-4af7-7539-08db51631677
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Rk0NynxCXQk9er2uFrbpp70yJ5fffGKeFt2rv1m6rpBGO4JQj7tbS7TRF3wZF2usF4cDEHmypLci9BmzsX1NF1eLBw2NZdgtkNl3GeUm4k4dTTvBvuDlu/GxHK9FmkzuzIa25/Y/Hv2OS65HMIWpMeqNr45Tq1aow7FdvPm0jaubt0X667BNcyh45jVF0WV9JPnAWo98Nms6nDbqQZ78PDedStlsp6hT5MOGajQBY39es+hlBJQCngHYJ4McWAWzeBVq+rq7QVfMNk5xCk3T+izmGRWj70/2GWGz5mx5uRdtDTZyRUM3E87NKPocb7Ypq+UdNRLOX58gKFQYsR2exGO6KK91d3tj+IWD5pfB+yaS1OlulYXAuSporeuz2y79Jn3z+xDvqGvcDgvcUsc/LXOd2W/Zy+V68aNFoXLjyA55GHEoY0sYX8J+zH/D1Vp9dlkaa/ELGmvdUVnKYMSoUy4oNtoysM3iS3I3lOWAd/0DQ5bi1hPfJOg1knwwv0hZiiW/qj/G2SEsfAofblKgXunaTqBAmLLsPG6o+0kpnYItppUq8vyCh24snvfAym5/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5979.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(346002)(376002)(136003)(39860400002)(396003)(366004)(451199021)(2906002)(26005)(6506007)(6512007)(9686003)(186003)(6666004)(33716001)(66556008)(41300700001)(6916009)(66946007)(316002)(66476007)(8676002)(8936002)(4326008)(6486002)(54906003)(478600001)(86362001)(107886003)(83380400001)(38100700002)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PvRgv/fBbukPxVqHrVBYgq2GkTCBdtjDfe4HoCgCigFh5vXkkk0dkeRjGFSt?=
 =?us-ascii?Q?ck60z8kP0nLmXFE/vcCKiK01V8k/+6z+4Jo9t6fOI8dAMMYh6N47VPzE01pp?=
 =?us-ascii?Q?kit2+H0ggoGO0T/CDvFemYcBd8EZhAoez837PQPjIl1txuF7GH3LEyiN25Z4?=
 =?us-ascii?Q?f//mQ6Sg/7fj2bCWrGkbUmuXuPMNZ+xAbNNqkqW7+F7Xm49hJIQ7Ii8z0je+?=
 =?us-ascii?Q?kJui3g7g/rtmIWGnUsHpC+6P9E8kovd+wwSlwPozXcJwPwGJFDYU94VtPwWk?=
 =?us-ascii?Q?uEaQLMQmsCfcx1mGAshc3piahAHZPw54c9uW9n8qmv3oy6znrdb5V3GQ7mFY?=
 =?us-ascii?Q?Jpfg+rqpgI81lbLiyJ9e89AbTRwII+Wwp1yoT5DbGwqrqhszGvXgtINr+/bU?=
 =?us-ascii?Q?k5rf8zLM512H112KsWrd7gp5gidsl5XlJI3knkKx6ohGALLtkAOV56CSWXpE?=
 =?us-ascii?Q?9dbaeOfZXsUa84D0Hb7T2xxAiSgbdaxQtpS4iw823A73OijmPdS5Eij7fMsT?=
 =?us-ascii?Q?C92Jd+Q4YqfuiCM41gPYPxPuRZdOPXHkL1tY/zg+pQZ2kVK2biGY+retU7/8?=
 =?us-ascii?Q?8TCU5kndUns2gmCjRjGyLXr2AVipqAe0NrcjYjjn1cz1I4vMda/J/+l286jA?=
 =?us-ascii?Q?ksJHYCw9ZZ4QiusnO732AC6lMmFKchIMrkzuqAYwDXjXfzyY+eInaArKhVN5?=
 =?us-ascii?Q?qkypvQCRfxhRmhzw698jrDcJ5cFAlPDJuT5HdH/PuMFJ2bOMUWNZToEbVqlw?=
 =?us-ascii?Q?q3mdyIZXPYjONmjOy4I5tUGGI07qFfOPqBbJxIHtFZExleD/siSG120H7ecX?=
 =?us-ascii?Q?9IPi8k3IHFLD4ne3IiiMJF0fdF899aQ5ASosNEpI8dUcG9x37lJQENusN95J?=
 =?us-ascii?Q?C1k3bW6zKgHsbGC688NzEkidkXuOtVqknbLJrQKvJg6Ee8kqFKTT/fINYcuq?=
 =?us-ascii?Q?ZH0RuPfG4thIet9ZNC7r8WfROLD2B2iYcgypiqerqvYEC4adbyOHznedX9I7?=
 =?us-ascii?Q?alPxhKOCdsaVDz0p7fqHs1Ur9qCyYZmRYm1kEt/4A4JdL4nlFE7NxymtuwXk?=
 =?us-ascii?Q?L1BXWdSefvakL5MAFosDipqIIKQDQL0RJ6DArwVsJK7gP1CpqW5Bb/NkDMm8?=
 =?us-ascii?Q?uZbG55eYDOrtXUPDGAkjXgU0OTtWXoic3jAbWm0sYQFs1seIbbzZjh/K3zGP?=
 =?us-ascii?Q?G5lbTl6w4bWhslJivVFhaZHYmV+09RIlKpxYUoO44jaC/TQNxgCjdyw3198I?=
 =?us-ascii?Q?/WSuGXBhZkHYUChCeesblDWmXJK8NTJN2LOVpqvrk/ZEfag57zN+xklsBk2m?=
 =?us-ascii?Q?aADPDpX3fD16N7vSxGbedNgi1Lfoo5H/+nLN83rD7gDkJoVL9SAvn792VNzQ?=
 =?us-ascii?Q?0fn3E4xF2MO2wHmS/a6lTkRAEtU08SfmRZEkq+CvMQi5VnKcYzAEAB2AG161?=
 =?us-ascii?Q?uRKzeu0yPgChGsObJHbq+uYq0+hvkigppP/QdbfwqvNkG4o5m03pqoru7Ekb?=
 =?us-ascii?Q?PCCVExNflTMY1ekBlLuHCeO9uQZutvm8AvZzus8WSq6QZOElJl9+8p6pmvOh?=
 =?us-ascii?Q?oe/tclbJa2mPM+5lhjXQQQD73NfU85xfMx6Vdd76?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24850252-1544-4af7-7539-08db51631677
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5979.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 14:30:22.5835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BanJMs9gAbF1bNPJzKrxtxSRgoGqHPqYiqVKTi1waQgzgWlM/1VX3LZohrcwt96B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7288
Subject: [virtio-dev] Re: [PATCH v13 00/10] Introduce device group and device management

Fri, May 05, 2023 at 05:40:33PM CEST, mst@redhat.com wrote:
>
>
>
>Change log:
>
>since 13:
>	command specific data is u8 again
>	exclude admin queues in blk's num_queues
>	minor other tweaks
>
>since 11:
>	addressed lots of comments, all minor. consistency with
>	outstanding number->index and queue->enqueue work
>	i did not intentionally drop any reviewed-by tags
>	as all changes are minor - if yours is missing it is
>	because I forgot to record it, sorry
>
>	one "breaking" change in response to stefan's comment:
>	in patch 5, num_queues has been specified not to include admin
>	queues: just regular ones.
>
>since v10:
>	addressed lots of comments by Jiri, Stefan. Cornelia, Lngshan, Parav, Max
>
>since v9:
>	addressed comments by Parav, Max, Cornelia, David and Zhu Lingshan:
>		added link to errno header from Linux
>		rename _MEM to _MEMBER
>		admin vq num is zero based
>		clarify who sends commands where
>		minor english tweaks
>		clarify command length
>		specify interaction with sriov capability
>		correct commit log - NumVFs can be 0
>
>	i could not decide what should happen when VFs are
>	disabled. for now did not specify.
>
>since v8:
>	addressed comments by Cornelia - as we agreed on list
>	
>since v7:
>	make high level error codes match linux, with virtio specific codes
>		in a separate field
>	renamed _ACCEPT to _USE since that's what it does
>	clarified forward compatibility and non pci transports
>	support multiple admin vqs
>	conformance statements
>	lots of changes all over the place to I changed author from Max
>	to myself. Don't need to take credit but also don't want
>	to blame Max for my mistakes.
>
>since v6:
>
>	- removed some extentions intended for future use.
>	  We'll do them when we get there.
>
>	- brought back command list query from v5 in a simplified form -
>	  it's here to address the case where a single parent
>	  can address multiple groups, such as PF addressing
>	  transport vq and sriov vfs.
>
>	- attempt to make terminology more formal.
>	In particular a term for whoever controls the group.
> 	I am still going back
>	and forth between "parent" and "owner" - owner might
>	be better after all since it will work if we ever
>	have a self group. For now it's parent.
>
>TODO (maybe?) - probably ok to defer until this part is upstream:
>
>	Add "all members" member id.
>
>	Add commands for MSI, feature discovery.
>
>	Add commands for transport vq.
>
>
>My intent is to try and support both SR-IOV and SIOV
>usecases with the same structure and maybe even the same
>VQ.
>
>For example, it might make sense to split creating/destroying
>SIOV devices from the transport passing data from the guest - the
>driver would then not negotiate VIRTIO_F_SR_IOV (which
>then means auto-provisioning).
>
>More ideas for use-cases:
>virtio VF features query and configuration space provisioning
>virtio VF resource (queues, msix vectors count) provisioning
>
>
>Future directions (shouldn't block this patch)
>- aborting commands - left for later. or is vq reset enough?
>- should we rename structures from admin to group admin?
>
>
>Michael S. Tsirkin (10):
>  virtio: document forward compatibility guarantees
>  admin: introduce device group and related concepts
>  admin: introduce group administration commands
>  admin: introduce virtio admin virtqueues
>  pci: add admin vq registers to virtio over pci
>  mmio: document ADMIN_VQ as reserved
>  ccw: document ADMIN_VQ as reserved
>  admin: command list discovery
>  admin: conformance clauses
>  ccw: document more reserved features
>
> admin.tex                        | 584 +++++++++++++++++++++++++++++++
> content.tex                      |  62 +++-
> device-types/blk/description.tex |   2 +-
> introduction.tex                 |   3 +
> transport-ccw.tex                |  14 +
> transport-mmio.tex               |  12 +
> transport-pci.tex                |  33 ++

Michael, not sure if it is problem of this patchset or on my side
but makepdf fails to build this. With master branch, works fine.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

