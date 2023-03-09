Return-Path: <virtio-dev-return-11559-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ABA6C64EC4
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 07:28:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id EAF7426A34
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 07:28:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E592C9866FF
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 07:28:28 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D85CB9866C1; Thu,  9 Mar 2023 07:28:28 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C3F439866F3;
	Thu,  9 Mar 2023 07:28:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i5Q2ACx+RPgxCPBp2YJe/dfanS54a3x+4A/ZlLHoa4T1jWslbVHm6CIsW+Pk9AAdCfj0C1ZPrzObV4ZfM7j+bdCNUgrAz+tToLWRHlttb02tqvqvg6Lciwz3XKuRBiJpE6VXGsMmry5IPORfvIyM1ENOWB8ofO2SznUWDDSHJDGEXj2A+sCQaeNL8yg9HhAMly8jUB9o/rLzijUauUR94qnSwR6/cJiCLpbZ9xted/sW7pyV7FURCy7wfQwh8bHMwUMcF8hWxEcUFeJwK3yNuXnAXDJ+i2sS7EYTdGvxC0hQzC6gRELbfWnwQXR1IwN61kU9VAQx2d62NvqTvBg+GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n4kd9aApwTu/FKjOO9QuaUszC07iPbmIo/QiIxwIC88=;
 b=RRHJWofhTI/9iaSIyVZUNaphp4/Y08qZjKh2S0MSVumjEunnYml2rg2IaG9sShC6m7q/80C72yGyLbUoHrA9O7teXz24Pd//eJtsQobnhxFUPA+HcSKHMawLArwjeYJjIke//d8WF/ElJnnP6faJzXQWhaCC311YvGZYaSTjQ1LwP8fdISdPTjNAZyv8ixEwGwhXUrmSiGjEhKJaSHSmAPMYXmAUV4fl0b4wonTLT0Z2wEYSpNNpHGcdtFLCwkWBh1loIcqkV+h6XVS7YWV/4VVRSNlJaGo6rmeu6xmOUno07k4kEYxutvRwPxE1kW4a42Kwaaqj0DvnN19z10jmKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Date: Thu, 9 Mar 2023 08:28:10 +0100
From: Jiri Pirko <jiri@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org, jasowang@redhat.com,
	cohuck@redhat.com, sgarzare@redhat.com, nrupal.jani@intel.com,
	Piotr.Uminski@intel.com, hang.yuan@intel.com,
	virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>,
	pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>,
	Parav Pandit <parav@nvidia.com>
Message-ID: <ZAmKikDSgtIKQaZw@nanopsycho>
References: <cover.1677761896.git.mst@redhat.com>
 <20c81b66f0b21b5bd646c24840ac3f8462c86acf.1677761896.git.mst@redhat.com>
 <20230302204007.GD2554028@fedora>
 <20230302190230-mutt-send-email-mst@kernel.org>
 <027fff1b-8ed7-abc0-2331-b188b8822bf4@nvidia.com>
 <20230306174850-mutt-send-email-mst@kernel.org>
 <e12ab469-4586-f0f5-b084-8f2d7c031e11@nvidia.com>
 <20230308160834-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308160834-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: ZR0P278CA0047.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::16) To MN0PR12MB5979.namprd12.prod.outlook.com
 (2603:10b6:208:37e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5979:EE_|DS0PR12MB8526:EE_
X-MS-Office365-Filtering-Correlation-Id: c41bf26a-e7d2-40e0-750f-08db206fd907
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZPpHM070qrVgXMe/BzIkpfmywCfA3u80XWKr5+QFqRP4WfHqgF5iXDV9HXDYRlv44jyVi430S3hH5pKxgcE4cMVuYxEPudP/WU7dj4C9vjklAkfK5uIYacmlXb9s/EOyz/pJRbORO7UO1bL6ZqFrMgEQV/+S+1ZspKZGj+LvEnM4mhcu26gC8O/3C2jOBFdstD11YXMnzsDNvDHUB5LNeSoe6mZmd9BbNIZniho11F8QC+Es3E1+AxG0/oGLww38rZW5Y7IzEJe1XNlHc6MndLWbldaizxpaRTnck3DOP3hY9YJS+dNdC8oI1YJgBNHZM3XTsgUZTew2aUcDE+yY4R4FVb+IT0JScnLT3Y2Up7vK6Jc1neU6R7xSt3ExF2DaYAWfcuIsh82FUyMtBLD0hCz4CAc7LWL5OGxHz0g8RlLJjr79tPKPqGIJYlRC2CUhRGGLCpz04TAtfwSOgjqxLc39jlY7HR59VGFZ2HAsKwOCrED8BeMHWDFRhsciGFIcOhYxrlIEO1EqAL24Uf/ZmLHlhxQwF2vCl5VU//iPUit/fJfg9JevX+OOeZgnvNkg8sKQN5j9PQYrmqeWzjiGWW5s/Za/n53ZgYrygJYXZ9/AxEw9we8lurPqlrC70QoygODZcVekLDRi4mi6Gg33Ow==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5979.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(451199018)(5660300002)(186003)(66556008)(9686003)(8676002)(7416002)(66946007)(66476007)(4744005)(6916009)(6486002)(4326008)(6512007)(316002)(86362001)(54906003)(6506007)(41300700001)(8936002)(478600001)(26005)(107886003)(38100700002)(6666004)(2906002)(83380400001)(33716001)(66899018);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LJ6VPmZg0YLwpwHi7q4LQrKTD8sqULFeaz8bDer4G30jtg4Sg4hvpRCTQkHy?=
 =?us-ascii?Q?r4oFBXv7/7H6y8vOrby45aNF3YktWPYj7pPFJdJEax3CsaksFg4vbAmkbGkt?=
 =?us-ascii?Q?3n6WFEkwpy2r3BgkjBu6sebmaAM7/uDqhZ4cQ0lx5rOTdTcQ+ijhzKcvZL2e?=
 =?us-ascii?Q?BkVSLt749LIjV/FFLemHFNeW4FawM0MC/64fVtxcf/OKWsznK1ZNX8tKfsRH?=
 =?us-ascii?Q?nIeE1mmDUyB8wbfOVsLWnmxTJSTJRiFzPIsfe0JiFIM7RlVgan4Lr8h1jtum?=
 =?us-ascii?Q?wvgzpPcwg6nD8UPnMG10IeBfLvvwo1HQjDPtLoYUxpnQpXlvB09PLsL0heTQ?=
 =?us-ascii?Q?AI2hhNJt08AMCCT8ROLwgNis3s8nzml8RlCBKyu/WkmCpBZZSfaomncPIU5Z?=
 =?us-ascii?Q?xte7drkgHcRkY4CONJt+fnuMh8a2yR2LJXHVzl8mF3x9S03zWysho3/Y1mSW?=
 =?us-ascii?Q?IR5KQgCCPYbk4qv51bX2ZzChDizB0KBHxDZR6K64HxYXYhehchZ3TFrWqjIG?=
 =?us-ascii?Q?jeZh4Gykjb79Gs6JMG0DayF7pzGMHJkFRhDMjQvI19AE3ZiJ/ufvuaviKplr?=
 =?us-ascii?Q?RMluF1fQ4ti8zz5OvIOisoq+2tPr34eIn7eqtNNAfFmGxYqBzdUEVayFmu/r?=
 =?us-ascii?Q?YQxB0UXtLw2XwVm2wQzNKHZC6uP6Qt2728aHJ45rv1VgT3OEXB3Ek2KyP281?=
 =?us-ascii?Q?2NFMOD9a7JNa9abAz0KO7bOSp25Md2fWRdqYckS5F+KQXWF5qxm/Gw3sPtMV?=
 =?us-ascii?Q?V7Qq/9uJiaeY0Vs69ggnZ7t4aXRmwlATfr5d+kMWU785qWN/DthRgX4rx4bT?=
 =?us-ascii?Q?epxGtCSbeQ2PxPX1OorYLYmgT7yb+yxZHctObPebV8xB+c7+tBKT9owxmUFv?=
 =?us-ascii?Q?tJ5dmTQDpIZjkSO5hOB4/cK41qDZSr4B+C7zqbKUD9kPVklDySM538ywE8NP?=
 =?us-ascii?Q?QkCWEOn9p/8LHbbGpuQ+pMuOurzr0/O5PcAUfrzhzg2kLo3Y34vTphLUITbl?=
 =?us-ascii?Q?i0s3z+uDKC9QtCsYvbvnKCxCclJ5CYMwE42W4DJ0beegJG6/QSeNaPx1E8co?=
 =?us-ascii?Q?ssaxwXJCMGupaEQ/BeLu4hTMUNJAvVUj4BOcGaFPjVX3dNxg97ZRb+RN/YB9?=
 =?us-ascii?Q?JMD3zsD/wtRtks6Oswt8b/Tv6mptEo2SazJaG1ILG8ncibQwYl+Uqy82iwSZ?=
 =?us-ascii?Q?2+9AtxjvMrxiD6V7CQMeDrYuyXnM3kWQ/ztILBRnrEUuQO9JgG37P8QnZRk9?=
 =?us-ascii?Q?IMbSb8T+3cvPxMdpAD1p3hCltoMh2xBQIPhhdROP99Hz+HoJBTn5oCt4t2Fc?=
 =?us-ascii?Q?C5uUjh+rx8a/ot/YAVhwh9/hObkK4fEJkG5I1oizD6xFPAlJQtH3YG+f4cIP?=
 =?us-ascii?Q?//nV5YYhWYJ8ywCVMzDQqa3SI0ynsuVtjsbcohWXpP0Ue+zE06E0qWfibDBo?=
 =?us-ascii?Q?mlnkONww2hCvxFLSxIWXFGgPvn1pgiFWar9HuC0sX+IOGVgbh5Bl8uJI8EMi?=
 =?us-ascii?Q?FDfIRpI8qPMg1+fNOcVhpP5U6uR0FVlPgPpzYX3Uh2TUCW+Lg4cetRSJ4a7h?=
 =?us-ascii?Q?722x0GdkS/FvACZeT8eb+kJDwXQ+6m2dBtEsjBhX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c41bf26a-e7d2-40e0-750f-08db206fd907
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5979.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 07:28:16.0159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZdbqsAfUD23ZVK3oRVhHZU8e+/k1nsCr7u6enPE4EsJ37UeAu7qt5jfARTkuM1cF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8526
Subject: Re: [virtio-dev] Re: [virtio-comment] Re: [PATCH v10 04/10] admin:
 introduce virtio admin virtqueues

Wed, Mar 08, 2023 at 10:09:22PM CET, mst@redhat.com wrote:
>On Wed, Mar 08, 2023 at 10:58:59PM +0200, Max Gurtovoy wrote:
>> We have a non-spec prototypes for LM so please use our experience in this
>> area.
>
>Don't see what the fuss is about.  Nothing will prevent your device from
>using a single queue if that is what you want.

Yeah. Plus designing the thing multiq in the spec from start is
future proof. I second that.


>
>-- 
>MST
>
>
>---------------------------------------------------------------------
>To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

