Return-Path: <virtio-dev-return-11477-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D47C8C678D4
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 11:32:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 421D72AC4E
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 11:32:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 393389866D2
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 11:32:05 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2E2F79866C2; Tue,  7 Mar 2023 11:32:05 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1905A9866C3;
	Tue,  7 Mar 2023 11:31:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+J4hKRkNBN2FG4uVon0JO6g2NQA9P0qttf98E1Gm6GJrtEMiBNNIDQsg0MfIpjSsZx8dsIjt5z3aP1p2sA+W9FpajpxGUSnMtdvLtS8LcJa0DY/pLC4LmWedX1NUnPDTIRtgPAYYJS1w+8wGP4mOchm6qhwd7mnSY3gAjfmkIPWmuGfM77VHPYSpipmvi3q2GeRMhmPGT9FdL7vWzG/C368AUVvb/66oEhMqlkYs5jDd/CVC3IzM4JZrm4q+1cGOFDS+w3Ph5Tj1+rTewOAdAoO68boSYvR4l3F/kVGko8EJnMmWCLrojJSqC9D+zO8hnak3Pg7sSSyYXH4zCQxZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Q6GSQjARR7mII0WbWyCQ1SqY+/i5EMqxTgXhrdENOA=;
 b=Evhq7JviLiZAINA5bjGcpaHTQjJ6udmFkCp+fQy02r9V8amaZqg1WkXVDUfvYJZvNrvww6zOt1wYMRiIBEuYN9UYMPam/eC5sSSy61gIFzvDXoptfxDR7tWst4edtiKQK+qI85OVV3ari8oHRdneEfXaoqF9T+bJo1fvYLNi4z/15yfmY3YA5eeI9bmdR0vnjQQKWO+8PUTO8FeBLVdN1tuGDPbRgLGIbjQB93fTklY8QgfpQ1sc9hdxDHZQYe+FViLALNiMjbvGUQtU/er4ya598H8b0LWgC76xxEGAE/N9dNlwBusKh6y2WDuydiFdZa4gVhPUwukQ6JzHGwH8iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Date: Tue, 7 Mar 2023 12:31:51 +0100
From: Jiri Pirko <jiri@nvidia.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org, jasowang@redhat.com,
	cohuck@redhat.com, sgarzare@redhat.com, nrupal.jani@intel.com,
	Piotr.Uminski@intel.com, hang.yuan@intel.com,
	virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>,
	pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <ZAcgp1UqrXQqLdVK@nanopsycho>
References: <cover.1677761896.git.mst@redhat.com>
 <910b3607a5f255134d30b3e1233e564f564eafb8.1677761896.git.mst@redhat.com>
 <20230302201011.GB2554028@fedora>
 <20230302185214-mutt-send-email-mst@kernel.org>
 <20230303131337.GA2866370@fedora>
 <20230303081515-mutt-send-email-mst@kernel.org>
 <20230303202314.GB2901137@fedora>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230303202314.GB2901137@fedora>
X-ClientProxiedBy: FR3P281CA0110.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::7) To MN0PR12MB5979.namprd12.prod.outlook.com
 (2603:10b6:208:37e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5979:EE_|CY5PR12MB6036:EE_
X-MS-Office365-Filtering-Correlation-Id: b8eb4f9c-1722-47da-ef1b-08db1eff8d73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	R6cY5sQ6Ptb4uIkZMmZMKSjVp0cT/iPCKA7F/mIEgKG9dMo9fl6ZzcAoNm8tjJPW3AbXOHoh76vcaLqa170xGXT5mvtfpfrgg4JLtRgnQCzgdrdj3Dcpt4C1nrAKo6pba22o4PkPxZc7RhhYZq7mHhYTq06GE1UP7ibBeuwaJxq/cN4A7X/Y0fV+T2Pfveph/xP2yV8o4vIKtNAihsXr8RmeBkml3JJYjRwR7AaUoCrlkF7g5zg4kqOjxbdAkMyTaIkUwgEgQ1l8BdWqIKkiFb1GdUj4LdwQiQrpVZKA8Cm8dIkZ0wmEQQIIkgZR9rzDBo1bkky8A93N6axRFyAVhpnwUcYVmsy96GE9VNl9DwO5lnlTK/SXrvurnJv1mlNFe2H+9bFFd8Cblqwbijoao7CgDHSKp+rjMBHaRtIXT9cSKaywuaaOfa2cOpim73XVUU1lqqoiopN65CYaAY5iOE5UER9xyXmeS3hidoVUFmWFsrKjXaWM5sg5LD7mUIEGFMLjLKfqcMDVR8ofs7g9vrih6u1GruP5lF/133C01HMvdzsc+hnGR28Mo4phlxjPE6DiSFXdWoa23v+NAAw/pYyt/nLQdkxbqdzJflemxhFAKqX37H9RQTcttjLEZP6jieSXJIC5R+vmN1bE218zHg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5979.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(4636009)(396003)(39860400002)(366004)(346002)(136003)(376002)(451199018)(316002)(54906003)(38100700002)(86362001)(186003)(6512007)(6506007)(107886003)(83380400001)(26005)(33716001)(9686003)(5660300002)(8936002)(478600001)(6486002)(7416002)(6666004)(4326008)(41300700001)(2906002)(6916009)(66946007)(66476007)(66556008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DlBOWuZ1Y7EFWTm0E6k/za5HxKGYc5TQChDXW6Lo6ZG6tUSurpxUK+rbtZCI?=
 =?us-ascii?Q?Ogh2xSd4pflQpQpXCHcKBlavz7agsTb6Dk0PK8sck2X5AgAbE3VRLYggg1H9?=
 =?us-ascii?Q?NKkkIVj85ZdJDc3qOXUf6Cd50bW/A4TkFAUxACzzu/Cb4Nl2o1elithq9/4H?=
 =?us-ascii?Q?YttLTs2AxHlq9IFw3Cs6EYhlN27ko+pBpdW5UXP4+gdW1GnOVlFelEzVCLLA?=
 =?us-ascii?Q?sO8/cwdlD8jlr7Cjg5Y87jRIZjp0s2IAJnU2Yb0zJ9TXtfzRYgySLA7+rL7q?=
 =?us-ascii?Q?aoBi2cFPaONRMmX2UghbPggKoUwrK7+l8hHVuRqb8lKIM2gPvX9sxdqgSeKq?=
 =?us-ascii?Q?/b2bmW0ibvr28FIVJazDu93zMNJXsBOHQFcGHHpHGApwqnpYHrLjtD8fILl/?=
 =?us-ascii?Q?Smf98WkeziO5C6/P1OGqlBJ8hArV1hs+VPsjCTSeRcWnPKDhYytOJhYrumQ/?=
 =?us-ascii?Q?S9JZj5hUp1iplyL33TpZ26LnZSeoAWe2T46TM7L7hoR6jJAk1bPnwrDnaBMS?=
 =?us-ascii?Q?tj+uxR4isNdsaFmd6sQsDFDxlj6HmMQlgEID74Zrm0m2YDi9s885bp4Po5Ra?=
 =?us-ascii?Q?/sqMp30dnSZ0KilApj6VWwejpwtvgRm5ThycG1zsc/9zAUnQRtHmMh6f2muV?=
 =?us-ascii?Q?Pgvh2LQgmy7hfBLD81FLfjutkA3A3i0QXvqmFDZl/FaMMW5wRWQ17+yNrVNf?=
 =?us-ascii?Q?2d4pCRvGsACE0Kj6j08637DYik15e2Su6DUokxbPN1Uihv4qG8eQ/jtVXFJB?=
 =?us-ascii?Q?L5Fm8nUx7sZZ+TZ7wo3nvZd3833Oo8O21oOxO8dS3bB2YeT9rtCWdZ+Es0dA?=
 =?us-ascii?Q?wNLWVSIrogLCk/nH+j8jRegCC3XTrxWhzCS4SAhgKoCvpJN4ZKW3/MCooeiK?=
 =?us-ascii?Q?1vsUWNomLH1yPIpGbl7QIqCZSwEtZaPHqiGrWJjGRrvRiZYj/GOCKGkG0pcv?=
 =?us-ascii?Q?PEMFChLRDHcZDsoMa4DJz4184eaVt4fxhosU0AMRvribpMjLt/kPWSRjnYB6?=
 =?us-ascii?Q?EZUMj062IWczvykWvNdQc7KKvtGdoo0zshQQBds0apIbMdGaRFTyf6COt+fn?=
 =?us-ascii?Q?8Uh3T+mCc3hDOiJ9sR5XL9TXe04pyzWp3HxmQoBbKf1YltFgk//FgtJIYWH5?=
 =?us-ascii?Q?s5+jp39RYvUzbpVKMTMQNhyD7VtDAFL9Qd93WOl/ASLOY8/bU/GeZ7Zw2Z6i?=
 =?us-ascii?Q?s56NbgIrfUL6I16SzL/zlHt/CoyIMhMwSbuWHPIEUUTCUHg20DH4FU0jOHKE?=
 =?us-ascii?Q?KrrKmbMzAfkHUarxXMkdr5yKFbmurDPc5VX6bHr+jBn80sW35RMT1Dk7eDsD?=
 =?us-ascii?Q?t2n3BreEIentlYEz7zjRINgbebRD3YgxoQtfQtM5xLnHs1ooskXgSyU7Zq7h?=
 =?us-ascii?Q?w2JQwB4FTvJk/dwQSOiu5FofkNLqAbw4ReFXWoArW3UMajXspbsOXT4V6rA1?=
 =?us-ascii?Q?FYF86Via+Mej+HCWb26zk3Gb/NMO1E/LQc9cp4oAhikWiLY3Srz9oAoWBb4F?=
 =?us-ascii?Q?6WwXM5N/zxvu+URy0+aGUBu6if08qW3U3ud3XWUg/1z1FJhiO0ZdfId7ZZrD?=
 =?us-ascii?Q?SXQIhCa39+mcVzyj/DG6BSbghQidXa0hw1blRQJ3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8eb4f9c-1722-47da-ef1b-08db1eff8d73
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5979.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 11:31:54.2985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E6XvVxfyZ5Nmpm4oVlYK6MI4bHF0DvjnmNoyaD/sIUGTGyGzRUx2P/dDqVclzHce
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6036
Subject: Re: [virtio-dev] Re: [PATCH v10 03/10] admin: introduce group
 administration commands

Fri, Mar 03, 2023 at 09:23:14PM CET, stefanha@redhat.com wrote:
>On Fri, Mar 03, 2023 at 08:18:43AM -0500, Michael S. Tsirkin wrote:
>> On Fri, Mar 03, 2023 at 08:13:37AM -0500, Stefan Hajnoczi wrote:
>> > On Thu, Mar 02, 2023 at 06:57:24PM -0500, Michael S. Tsirkin wrote:
>> > > On Thu, Mar 02, 2023 at 03:10:11PM -0500, Stefan Hajnoczi wrote:
>> > > > On Thu, Mar 02, 2023 at 08:05:02AM -0500, Michael S. Tsirkin wrote:
>> > > > > This introduces a general structure for group administration commands,
>> > > > > used to control device groups through their owner.
>> > > > > 
>> > > > > Following patches will introduce specific commands and an interface for
>> > > > > submitting these commands to the owner.
>> > > > > 
>> > > > > Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>> > > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> > > > > ---
>> > > > >  admin.tex        | 108 +++++++++++++++++++++++++++++++++++++++++++++++
>> > > > >  introduction.tex |   3 ++
>> > > > >  2 files changed, 111 insertions(+)
>> > > > > 
>> > > > > diff --git a/admin.tex b/admin.tex
>> > > > > index 3dc47be..7e28b77 100644
>> > > > > --- a/admin.tex
>> > > > > +++ b/admin.tex
>> > > > > @@ -46,4 +46,112 @@ \section{Device groups}\label{sec:Basic Facilities of a Virtio Device / Device g
>> > > > >  PCI transport (see \ref{sec:Virtio Transport Options / Virtio Over PCI Bus}).
>> > > > >  \end{description}
>> > > > >  
>> > > > > +\subsection{Group administration commands}\label{sec:Basic Facilities of a Virtio Device / Device groups / Group administration commands}
>> > > > >  
>> > > > > +The driver sends group administration commands to the owner device of
>> > > > 
>> > > > I notice that the terminology is simply "the driver". "Owner driver"
>> > > > and "group member driver" might be clearer because there will be two
>> > > > (possibly different) drivers involved.
>> > > 
>> > > Hmm I don't really want to repeat owner everywhere.
>> > > I will clarify that in this section simple "driver" and "device" are
>> > > owner, "member device" and "member driver" is always called explicitly.
>> > 
>> > Sounds good.
>> > 
>> > > > > +a group to control member devices of the group.
>> > > > > +This mechanism can
>> > > > > +be used, for example, to configure a member device before it is
>> > > > > +initialized by its driver.
>> > > > > +\footnote{The term "administration" is intended to be interpreted
>> > > > > +widely to include any kind of control. See specific commands
>> > > > > +for detail.}
>> > > > > +
>> > > > > +All the group administration commands are of the following form:
>> > > > > +
>> > > > > +\begin{lstlisting}
>> > > > > +struct virtio_admin_cmd {
>> > > > > +        /* Device-readable part */
>> > > > > +        le16 opcode;
>> > > > > +        /*
>> > > > > +         * 1 - SR-IOV
>> > > > > +         * 2 - 65535 reserved
>> > > > > +         */
>> > > > > +        le16 group_type;
>> > > > > +        /* unused, reserved for future extensions */
>> > > > > +        u8 reserved1[12];
>> > > > > +        le64 group_member_id;
>> > > > > +        u8 command_specific_data[];
>> > > > > +
>> > > > > +        /* Device-writable part */
>> > > > > +        le16 status;
>> > > > > +        le16 status_qualifier;
>> > > > > +        /* unused, reserved for future extensions */
>> > > > > +        u8 reserved2[4];
>> > > > > +        u8 command_specific_result[];
>> > > > > +};
>> > > > > +\end{lstlisting}
>> > > > > +
>> > > > > +For all commands, \field{opcode}, \field{group_type} and if
>> > > > > +necessary \field{group_member_id} and \field{command_specific_data} are
>> > > > > +set by the driver, and the owner device sets \field{status} and if
>> > > > > +needed \field{status_qualifier} and
>> > > > > +\field{command_specific_result}.
>> > > > > +
>> > > > > +Generally, any unused device-readable fields are set to zero by the driver
>> > > > > +and ignored by the device.  Any unused device-writeable fields are set to zero
>> > > > > +by the device and ignored by the driver.
>> > > > > +
>> > > > > +\field{opcode} specifies the command. The valid
>> > > > > +values for \field{opcode} can be found in the following table:
>> > > > > +
>> > > > > +\begin{tabular}{|l|l|}
>> > > > > +\hline
>> > > > > +opcode & Name & Command Description \\
>> > > > > +\hline \hline
>> > > > > +0x0000 - 0x7FFF & - &  Group administration commands    \\
>> > > > > +\hline
>> > > > > +0x8000 - 0xFFFF & - & Reserved    \\
>> > > > > +\hline
>> > > > > +\end{tabular}
>> > > > 
>> > > > I thought all commands are "group administration commands" but this
>> > > > table makes it look like they are just a subset (0x0000 - 0x7FFF) of
>> > > > group administration commands, which is a paradox.
>> > > 
>> > > Well the rest are reserved, maybe we will have more command types who
>> > > knows. No?
>> > 
>> > I see. Does that mean the reserved commands don't need to be in the same
>> > format as struct virtio_admin_cmd?
>> 
>> I am not good in predicting future ...
>> 
>> > The entire section is called "Group administration commands" but I get
>> > the impression it's talking both about admin virtqueue commands in
>> > general and specifically about group administration commands.
>> > 
>> > Is it possible to structure this as follows:
>> > 
>> >   Admin Commands
>> >     ...common stuff...
>> >     Group Administration Commands (0x0000-0x7fff)
>> >       ...specific to group administration commands...
>> >     Reserved (0x8000-0xffff)
>> 
>> What if I just write it like this:
>> 
>> 
>> > > > > +\hline \hline
>> > > > > +0x0000 - 0x7FFF & - &  commands using struct virtio_admin_cmd    \\
>> > > > > +\hline
>> > > > > +0x8000 - 0xFFFF & - & Reserved for future commands (possibly using a different structure)    \\
>> 
>> 
>> will this address the comment?
>
>Yes, thanks.

What is the reason for having this table? I fail to see it.


>
>Stefan



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

