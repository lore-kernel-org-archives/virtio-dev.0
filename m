Return-Path: <virtio-dev-return-11469-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04701C678D4
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 07:56:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 609C533585
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 07:56:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 58B559866DC
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 07:56:22 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4D6CC9866C9; Tue,  7 Mar 2023 07:56:22 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 39DE09866C2;
	Tue,  7 Mar 2023 07:56:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nwzo9NCLEYG3nng9MExTkEqs4A0lW9bidKYVZO3Al63++7CEYrlT/GxGheoa8jrvkc5T3AlLRUCN8sxg2gVROApzZ0rhx5ts5L9b93OwErCGPD/y0BgoIiGrv5GB1ZZpP89gUMRwiocQ8/d4MJdKw27Z8/XfptNpZyJtasAwh4rIRauhh+8VrJnXTLKiXu9mOAtYXJ3tNL9s05lpaTjyx8FaKple5Oyl7riqMWO2bjvkhBFVVteRs4x3h7k6VCofiOqMlHahBuShiFi05PXCRijUa/mqmBh9IzjQdXUVlU6RCZXm96QJfe7lPo3Y2oc1ynSFsX42RyC8feY5Jg7GDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ukdw/L4qumyl7d+D8IcxoXlgqPaXrLylrfE8U6JT+/8=;
 b=gYJXCXQrVPvelyiMkm6aT/jXE9D0XxKqa3gpB/ww+GIk0q2YjY5aOTc3LXuLtDPSKJGV46Bue6i1kvTtmIfFVXedtOrZ0STKvcbPGuuJF9Zgss1PCfU9bQss0WSRbbLShbNfogVuNhJQJwg22Kbmdo6nJFcu6KrOAo+VbQ5DZYGLBxXq924O38H8McFJvnaPaca/86FB6sA6Vwfb9iZwm/Q3ZRUcBq9v+P/x0G32vAMHu169z9hzmXpYLUQ+i3uYnxSPG22lYJ5JQfGzXMwCwRWyVPatI/m5EdMsRrVaCH969EG6mugWTM0FoLOztHPtzsZrTgrcPuD+QEhly4+iRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Date: Tue, 7 Mar 2023 08:56:08 +0100
From: Jiri Pirko <jiri@nvidia.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org, jasowang@redhat.com,
	cohuck@redhat.com, sgarzare@redhat.com, nrupal.jani@intel.com,
	Piotr.Uminski@intel.com, hang.yuan@intel.com,
	virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>,
	pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>,
	Parav Pandit <parav@nvidia.com>
Message-ID: <ZAbuGE0E445bOB+R@nanopsycho>
References: <cover.1677761896.git.mst@redhat.com>
 <20c81b66f0b21b5bd646c24840ac3f8462c86acf.1677761896.git.mst@redhat.com>
 <20230302204007.GD2554028@fedora>
 <20230302190230-mutt-send-email-mst@kernel.org>
 <027fff1b-8ed7-abc0-2331-b188b8822bf4@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <027fff1b-8ed7-abc0-2331-b188b8822bf4@nvidia.com>
X-ClientProxiedBy: FR2P281CA0070.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::9) To MN0PR12MB5979.namprd12.prod.outlook.com
 (2603:10b6:208:37e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5979:EE_|DM4PR12MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: 2adc7f01-3994-45d1-9279-08db1ee16c0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YeQvZkwToPBpUk0qQmtNEBw242REP/wk1dyPzKSfvlFSRS27iVLwW/hXBP/pPhj5cBJJwc65mmE+LWQGFVLk90ofX5DaoBfmNoNkndUt3foWUlhkWVn9C30Oi1iSnoqbOjIyw1QEw07z7vN5U99NPnQowvdK50vRkUev8DhehFzmNxEue5lwhji3Rk9OtXKmCJI6CRKP2EnGeREJDJIHM59UumUQFXlW3VQ+fh+Poxyj8kt6Ht3ZSQEQrJw3Mmht/fqWFe/fmgtuM7GVo2AHV9Hb9vgJr9mAPpUyouPSj9xddCniLxa5mfHlr+WcxKR17FiiOYo6SxTmQ7sBsy4iMdT8VdeK1Gn7GpwoRDxj+n1CeqnyG8DPWRPZbR/nXllqymKSQfVlpVS4n17lCF9C1YET26jaZjjwU4M8rCbbqLoWSEZPqH32nye2aMdTLodc7D/OPXZ8F4zZuD7cUVBi+b+kbodZ5aDJKGzV/N2fD0n/tyJsidkXtqWqFU2sqIJWHQvvmrbJ6e8JpX8w1hMWVRLKAlgdy3J8Z9xzPEKtsNV1yy/81k6KEexzI/eEeFoO4Pzm3Uk/Hbn4+K35flutTII+ABBH9yU1gCF0uK9efoaVjesYi0NguJ+EjBHEXNvPtQyp3D6zJUNjyaIvEVtYhcSkj7UA/rW5pB59CwTCmZ48I6sNaF6RDUEAufOdwfGbd2djjW+V1K+KhNvEksbPOfWPzSgLKplvWJERTdpE4i5PncQTUF1phRs225QjI191yhetwUBLBs0PYj8hpRWOgQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5979.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(376002)(39860400002)(366004)(136003)(396003)(346002)(451199018)(2906002)(7416002)(5660300002)(6862004)(66899018)(8936002)(41300700001)(4326008)(66476007)(66556008)(66946007)(8676002)(83380400001)(316002)(6636002)(54906003)(6666004)(107886003)(478600001)(6486002)(966005)(6506007)(6512007)(86362001)(9686003)(33716001)(26005)(38100700002)(186003)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vvL9uz3Snp8H3lGp5eOTLLDeFQY6aKsPJQRySHwsP5ArUEotxIIyUjrYa2UJ?=
 =?us-ascii?Q?opTUMhgQnkBcFAMXquTioD2sa97XnbrlwjT9Kt8XWamMIvTrS8jBntnImJW3?=
 =?us-ascii?Q?Aa2/g3IfGcigRXYIp1YJ5afXMPQ8iVyS5gkfrzJC/AiLZAUUBeNvtuTgY7Ev?=
 =?us-ascii?Q?i91qXHjJDGwSDsLUJfwNRsbpUT9/nB8qthb/cF6jm7Tl7BsEr+reyW7/tkMp?=
 =?us-ascii?Q?LlEEer5YMxJgruwV9o3mlsJIyNo+izIKj5+iFSqfdIy83bz6cRDhsv/fDYns?=
 =?us-ascii?Q?ArWO+TAyctZJpbVzAgYhBQnXM9C9Av2Av7PFvAnsCXBErhYcyQnrDHLJ3RYc?=
 =?us-ascii?Q?z3dbu9IkS/y2s2zRnjKe4KgIMAyFgw5BdVNJORbxXPPkqdzPnB4c3r1n5Q4s?=
 =?us-ascii?Q?dFPsBqmoG1Mjy0dHeRIQV73gvLCntRu7DBsbABC2fZmsgdaImcmOYQ76vNUv?=
 =?us-ascii?Q?T9UzJ+X+E1NWKSH8x8J318jJ07WlnZgQuSyZyUOBKlxsZjz+rZxx8d/w29UG?=
 =?us-ascii?Q?qkakL4r5dqQHyawt5BD6NvGOS934+RjTriJGQ/4TKvfH2hubLKS0d3AWyNy9?=
 =?us-ascii?Q?7JgVt0jmAO1UudpRZQij9yTodArIDp2YUnilrAh+yLCFG5V4zuRz6L4zqa82?=
 =?us-ascii?Q?wbvjBXB1LqGtWLb5mXclMymb0Q3z04KTd3in1867EPsvYNEPQMULEu4sIR5I?=
 =?us-ascii?Q?casf2hI+0zesr3APcp9PSQrg5seqJUo15xrrtULBBwhYZ8Jqfubotbxo35U1?=
 =?us-ascii?Q?yxg7wmPhArBnTCX4m1O9B02jKW0XGHase1lJycF4NCFqCHoR5FUccX7Vlakk?=
 =?us-ascii?Q?EA6k4pGePyB+Oz+El9grsjnoNrZHjGEP9JC8XgI3CgLZF2M+fqfqoJTsYAIB?=
 =?us-ascii?Q?lUjA6GMdxuBu1pNR+NkFlGs7R2W+ilJGsBDStdL6s9KNqY4bo35IcH4R3TgA?=
 =?us-ascii?Q?OHdpsJ6r5LjU8IheG5aJ0F47cL/ZkY3eGYTM0kpnD5O00p8Q2W/xBOCn/anJ?=
 =?us-ascii?Q?yx7sHZnNo0w1kQ4G0ev7HwwwrDYpQ8FpM42vbpXlWvS1YepunzkspZbfahqK?=
 =?us-ascii?Q?MjvjGTocUXbLNHuKSIDAW+pg7kk1oTkCI+gOXTtGOm0oih/09aoLTWWrnTno?=
 =?us-ascii?Q?AE1mj/d52LsADhMowDKfAERl290YJhmPvKWTg97uYWb/yyBvJzWYvZQ4Ogli?=
 =?us-ascii?Q?SbwaHamtIRC5+jF7dgBcgb30fGFuUjHWQqK2UB0w/Riu7BQ05R4EZA2D96xa?=
 =?us-ascii?Q?2fIY1ZAbrrigKxwz+m/n4HRCwg9M8wI5w4LVetebSSwiPit0l/XdfIe3P/ks?=
 =?us-ascii?Q?/WE6CPPbQbyC708jJ+onpXGBMyHStrU0cuHdhb4O99ZLWRRUSQj53h70+Tp+?=
 =?us-ascii?Q?dTrLom2gW29kQ5o+ZCNV+Warx+KFSqQL19e//6XfLuoIK7DpnAgc0nAkLa9D?=
 =?us-ascii?Q?D/wwF6yL+qBln+7dUkyMVeyp6mkbCOPpDl7NA/1bXjNwr2s/xn0LxAPiwrWe?=
 =?us-ascii?Q?yDS8WOb/6ElQQQca7phgWd2cs2fbMGWy+Sfs2F7eWJ6a/26bgvyY4EKwy+I7?=
 =?us-ascii?Q?uQ8ZXgELKVcjWbYMlRSSTiv+tNe/CtMqe9NQ7HUw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2adc7f01-3994-45d1-9279-08db1ee16c0c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5979.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 07:56:13.5576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IKbSAdioL09bXbbma2mnuWsNO3fv2nVK/kuSeEvOyVBuTpQ0/UYejJ1wWlA7/tPK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8451
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH v10 04/10] admin: introduce virtio
 admin virtqueues

Mon, Mar 06, 2023 at 04:14:09PM CET, mgurtovoy@nvidia.com wrote:
>
>
>On 03/03/2023 2:05, Michael S. Tsirkin wrote:
>> On Thu, Mar 02, 2023 at 03:40:07PM -0500, Stefan Hajnoczi wrote:
>> > On Thu, Mar 02, 2023 at 08:05:06AM -0500, Michael S. Tsirkin wrote:
>> > > The admin virtqueues will be the first interface to issue admin commands.
>> > > 
>> > > Currently virtio specification defines control virtqueue to manipulate
>> > > features and configuration of the device it operates on. However,
>> > > control virtqueue commands are device type specific, which makes it very
>> > > difficult to extend for device agnostic commands.
>> > > 
>> > > To support this requirement in a more generic way, this patch introduces
>> > > a new admin virtqueue interface.
>> > 
>> > Is this referring to the existing virtio-net, virtio-scsi, etc control
>> > virtqueues?
>> > 
>> > I see the admin virtqueue as the virtqueue equivalent to transport
>> > feature bits. The admin queue does nothing device type-specific (net,
>> > scsi, etc) and instead focusses on transport and core virtio tasks.
>> > 
>> > Keeping the device-specific virtqueue separate from the admin virtqueue
>> > is simpler and has fewer potential problems. I don't think creating
>> > common infrastructure for device-specific control virtqueues across
>> > device types worthwhile or within the scope of this patch series.
>> 
>> yes this commit log is outdated. referred to original
>> proposal by Max which also planned to replace cvq.
>> will update.
>> 
>> 
>> > > We also support more than one admin virtqueue, for QoS and
>> > > scalability requirements.
>> > > 
>> > > Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> > > ---
>> > >   admin.tex   | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>> > >   content.tex |  7 +++--
>> > >   2 files changed, 79 insertions(+), 2 deletions(-)
>> > > 
>> > > diff --git a/admin.tex b/admin.tex
>> > > index 7e28b77..3ffac2e 100644
>> > > --- a/admin.tex
>> > > +++ b/admin.tex
>> > > @@ -155,3 +155,77 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
>> > >   \field{command_specific_data} and \field{command_specific_result}
>> > >   depends on these structures and is described separately or is
>> > >   implicit in the structure description.
>> > > +
>> > > +\section{Administration Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Administration Virtqueues}
>> > > +
>> > > +An administration virtqueue of an owner device is used to submit
>> > > +group administration commands. An owner device can have more
>> > > +than one administration virtqueue.
>> > > +
>> > > +If VIRTIO_F_ADMIN_VQ has been negotiated, an owner device exposes one
>> > > +or more adminstration virtqueues. The number and locations of the
>> > > +administration virtqueues are exposed by the owner device in a transport
>> > > +specific manner.
>> > > +
>> > > +The driver submits commands by queueing them to an arbitrary
>> > > +administration virtqueue, and they are processed by the
>> > > +device in the order in which they are queued. It is the
>> > > +responsibility of the driver to ensure ordering for commands
>> > > +placed on different administration virtqueues, because they will
>> > > +be executed with no order constraints.
>> > 
>> > Does "they are processed by the device in the order in which they are
>> > queued" mean only 1 admin command can be running at any given time and
>> > therefore they will complete in order? This would allow pipelining
>> > dependent commands but prevent long-running commands because the
>> > virtqueue is blocked while executing a command.
>> 
>> we have multiple vqs for that.
>
>why do we need multiple admin vqs ?
>This is not performance oriented queue.
>I don't think we need that.
>I introduced F_AQ_IN_ORDER feature bit to distinguish the in_order logic
>(same as we have for data queues).
>Please re-think using this instead of complicating ourselves to multi AQ
>specification.

Well, out of order processing is parallel to multiple queues isn't it?
The only way to achieve that would require to have the same about of
queues as possible parallel out of order commands, which does not
make sense, does it?


>
>We have a single ctrl vq so no need to introduce multiple admin vqs...
>
>> 
>> > > +
>> > > +Administration virtqueues are used as follows:
>> > > +\begin{itemize}
>> > > +\item The driver submits the command using the \field{struct virtio_admin_cmd}
>> > > +structure using a buffer consisting of two parts: a device-readable one followed by a
>> > > +device-writable one.
>> > > +\item the device-readable part includes fields from \field{opcode}
>> > > +through \field{command_specific_data}.
>> > > +\item the device-writeable buffer includes fields from \field{status}
>> > > +through \field{command_specific_result} inclusive.
>> > > +\end{itemize}
>> > > +
>> > > +For each command, this specification describes a distinct
>> > > +format structure used for \field{command_specific_data} and
>> > > +\field{command_specific_result}, the length of these fields
>> > > +depends on the command.
>> > > +
>> > > +However, to ensure forward compatibility
>> > > +\begin{itemize}
>> > > +\item drivers are allowed to submit buffers that are longer
>> > > +than what the device expects
>> > > +(that is, longer than the length of
>> > > +\field{opcode} through \field{command_specific_data}).
>> > > +This allows the driver to maintain
>> > > +a single format structure even if some structure fields are
>> > > +unused by the device.
>> > > +\item drivers are allowed to submit buffers that are shorter
>> > > +than what the device expects
>> > > +(that is, shorter than the length of \field{status} through
>> > > +\field{command_specific_result}). This allows the device to maintain
>> > > +a single format structure even if some structure fields are
>> > > +unused by the driver.
>> > > +\end{itemize}
>> > > +
>> > > +The device compares the length of each part (device-readable and
>> > > +device-writeable) of the buffer as submitted by driver to what it
>> > > +expects and then silently truncates the structures to either the
>> > > +length submitted by the driver, or the length described in this
>> > > +specification, whichever is shorter.  The device silently ignores
>> > > +any data falling outside the shorter of the two lengths. Any
>> > > +missing fields are interpreted as set to zero.
>> > > +
>> > > +Similarly, the driver compares the used buffer length
>> > > +of the buffer to what it expects and then silently
>> > > +truncates the structure to the used buffer length.
>> > > +The driver silently ignores any data falling outside
>> > > +the used buffer length reported by the device.  Any missing
>> > > +fields are interpreted as set to zero.
>> > > +
>> > > +This simplifies driver and device implementations since the
>> > > +driver/device can simply maintain a single large structure (such
>> > > +as a C structure) for a command and its result. As new versions
>> > > +of the specification are designed, new fields can be added to the
>> > > +tail of a structure, with the driver/device using the full
>> > > +structure without concern for versioning.
>> > > +>>>>>>> 0edc690... admin: introduce virtio admin virtqueues
>> > 
>> > A merge conflict line crept into the patch?
>> 
>> yes. I fixed it I thought but somehow it's still there :(
>> 
>> > > diff --git a/content.tex b/content.tex
>> > > index ffe45c4..c8647c9 100644
>> > > --- a/content.tex
>> > > +++ b/content.tex
>> > > @@ -99,10 +99,10 @@ \section{Feature Bits}\label{sec:Basic Facilities of a Virtio Device / Feature B
>> > >   \begin{description}
>> > >   \item[0 to 23, and 50 to 127] Feature bits for the specific device type
>> > > -\item[24 to 40] Feature bits reserved for extensions to the queue and
>> > > +\item[24 to 41] Feature bits reserved for extensions to the queue and
>> > >     feature negotiation mechanisms
>> > > -\item[41 to 49, and 128 and above] Feature bits reserved for future extensions.
>> > > +\item[42 to 49, and 128 and above] Feature bits reserved for future extensions.
>> > >   \end{description}
>> > >   \begin{note}
>> > > @@ -7682,6 +7682,9 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>> > >     that the driver can reset a queue individually.
>> > >     See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}.
>> > > +  \item[VIRTIO_F_ADMIN_VQ(41)] This feature indicates that the device exposes one or more
>> > > +  administration virtqueues.
>> > > +
>> > >   \end{description}
>> > >   \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
>> > > -- 
>> > > MST
>> > > 
>> 
>> 
>
>This publicly archived list offers a means to provide input to the
>OASIS Virtual I/O Device (VIRTIO) TC.
>
>In order to verify user consent to the Feedback License terms and
>to minimize spam in the list archive, subscription is required
>before posting.
>
>Subscribe: virtio-comment-subscribe@lists.oasis-open.org
>Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
>List help: virtio-comment-help@lists.oasis-open.org
>List archive: https://lists.oasis-open.org/archives/virtio-comment/
>Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
>List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
>Committee: https://www.oasis-open.org/committees/virtio/
>Join OASIS: https://www.oasis-open.org/join/
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

