Return-Path: <virtio-dev-return-11911-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA63C761A6
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 15:54:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 176EA2A8E4
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 15:54:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0E8DA986599
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 15:54:15 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 033A79863D6; Mon,  3 Apr 2023 15:54:15 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E3A829863DE;
	Mon,  3 Apr 2023 15:54:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hve5zJ+IooIXKQvk2sKYscGx/+lTkXsADPfJ7GWEqoXUR9kRit9L7ydrlr/0g7GVFC82FKFvWtrkbb0w3SLEcebs/dQJoWuoOg7sVM75E3uzgcKmdt3+h3mVDQetnWD/xHcKus+o7qcekFg8CVNXVKI2QbGjEfDFHKiKVrD4B6Pds2kHdiM8uZ5D8rnfs9FWh0bBCN/smGOmP/LG8xZlams4BQTB8pwOobAyA6prVrwYKmRxgSg8Ov6zjfSulrdeZTj7rEai1N6vMbIGI+zzX/tKzVUNkzGdygQRcn//nnMg2rBBV0PmDMRt0eYVw0EIRo45/uKCoRIfhaiOYVA2+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+yNa6eAW+Y31TgU6fA8T1iqnVUweHqCLkIm3uAcb9qk=;
 b=db8rXwDKQSsc4HYmdhkQjdkx8Xj14GR9zqsUrwj7BbKRpbnu4cLNYmwy99obs/+q/VsaM7nmMN0VXxDKfF4q28yKVeOQtuUHiu+DLRatD6VPlqw1g4dEJ1oJ/mKf82gWYRIxvk747lKNlFFOhhfj+z2c72wubSTeLyz+TF6kQAZ+e7WpIUmmtDDiSLd8DqMTlsofuA0AOV3XA+dMSmpJVLYB8JcslT2S5e/rzyrQLL2RWqDkmI8tT4m2XAIMDpi9CdWkMjuJtcQYr0VWFFe0HljgVcvC30Kyg9/uk1yrDZamXzC08xh2rmqZS8cAMC/IA1Ag+yFqGze0GynoSlVTPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Message-ID: <8f9df843-247c-df96-bae5-4e4c2b2d1e8e@nvidia.com>
Date: Mon, 3 Apr 2023 11:54:04 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>,
 virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
 jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
 stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com,
 hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Jiri Pirko <jiri@nvidia.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
 Shahaf Shuler <shahafs@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
References: <cover.1680533760.git.mst@redhat.com>
 <aa6e3f39c4db34f3cf50a650cffeb0180d89e616.1680533760.git.mst@redhat.com>
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <aa6e3f39c4db34f3cf50a650cffeb0180d89e616.1680533760.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0020.namprd05.prod.outlook.com
 (2603:10b6:803:40::33) To PH0PR12MB5481.namprd12.prod.outlook.com
 (2603:10b6:510:d4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_|SA3PR12MB7999:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c5e94a0-f96f-4b3e-7005-08db345ba8f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	P8R9894COpCDfBnMPQSWT9Zbt1KjvqIim78kXu0wMTgY1czLdsOye/j7E2BdG8mr5Fi65tU3K46snfNBFiwIKucbwinB2wZRv9pAHvxsnxjRX8qRHUTbixvinCIv7XVGyo5oQvJ3Xm3QmoFGRSINOPWvCbGx/jkIVDftPFkWnGeYd6bm2Gdp4YYdamJnWe5zxn3b5K2f9Tx8/kD3Y3Vp7wbfhiax8ZLOdFSuQNJC7xkwGn/UILFVC5mMS6WSSddn08J++2MgVwpiYi249OFylgsktw/4dsPQoWKNjaTroAQnvcLJIORU917/SxId1CzhdeabMndRjrdRpJfajhHhW6U6ov6HuGhU/7ZysF+0Lli+Zy/hwtuD+8ohvGEE1j4k72yAptk07KQvBuVli/H5Z5YuSU0s/JIFSTqGToZxesqpIjTJ/XmHghVVpIPDSWMYC26JzRtVcE8FJhl6R5hhoU7IbNLPbZX2HwbZm1lXrDRsMDa5hpHbnB2Ou8OnopbEtIu/0mZMJjz1DbMnWftVzzpT7NOBRVpv7tuaGvKZMjRKeo/6IOAb9xFzZIU8OE6I9NMe2fqXUhfpHZIBSe7L9KqLU/pCIwtQl6sQag38ix14AoOItymOB0w7UMkYF8FVkGQgpvt4lMXvvltezdr2MC2wIh92+O1um4suJA0MHUU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(451199021)(921005)(66556008)(316002)(66476007)(41300700001)(31686004)(66946007)(4326008)(8676002)(5660300002)(7416002)(54906003)(8936002)(38100700002)(31696002)(478600001)(86362001)(2906002)(6486002)(186003)(6512007)(107886003)(6666004)(26005)(53546011)(6506007)(36756003)(83380400001)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SXVtZWNlK2RPdEl3NVpBTHRCN3dpRmU3ZFJDK0I0dmVoMjhUWk1iOU5EUk9m?=
 =?utf-8?B?THpIT3BFN2l4Mk51UGxtQncrNEhQdjVleUpjV0x2VmllZVFmcUR2RkdmSlFn?=
 =?utf-8?B?b29yOXdDTndSVDBLUzB5YTVyRmxtKzhEMSsydmUrOGlhTDkrVUViemx5TDZv?=
 =?utf-8?B?VWNQb3gxNDRwMnhnUmsyL3JBVHJaZVZLZ3NBSHk1bzFKcFBHb1Z1NnBGdnJC?=
 =?utf-8?B?ay8vZnE5RFF6UXdNQUFBU2kzTTJmem10Z3U2OUxQWXpyU2NQbWI1b0lHVE5u?=
 =?utf-8?B?ZGlFUmg1WTcwMVRETE9KTWVqRlNwNDFrbmVQQjBtSytYMjVWNWwvWnptTlRk?=
 =?utf-8?B?aGFNL1ZSeHRMYVM5ME5Sa2dQZ1UreWdUTHFvQnJ2c0hOMEV0TzdHNkF5dEdS?=
 =?utf-8?B?NkpoRGpKSU5kUU53UU9pQk03V3lLZ3JBNUM5Mm9yUzVveG5aSzFoZFFLUUdm?=
 =?utf-8?B?amdVdmNRZkhYVXFMNncxWXNKLzdqblNiWUFJSHRsRzZ4bUNRR2tqSXVwdmJW?=
 =?utf-8?B?SEhWNU11T0VnTUJCMThEODNNWExNM3ZBN0xDRGt5VFdyencrcWdYSXA5YmZ5?=
 =?utf-8?B?WFpmbjFleG4yUktEdW11RjF6bW0wS000Y0d5eEREVXJQYnRJQzlaMEpsd0hY?=
 =?utf-8?B?aVVBRmxTTjVQZXNYck9QZDFpdGladEpyMmU0ZWRBSTJ2cVM2aExsbEZrZytr?=
 =?utf-8?B?U1VJcjhIdzZaUk9FOHYrazdzUlVQZk1lWW90WWtQcG1SS3g2dnVvaEtEVTY5?=
 =?utf-8?B?NGF1NStKQTFrQXRzendPWll1eWdTWGhEbnRkaWF1cEF4TEhhRWdGTVowTldn?=
 =?utf-8?B?OXpldUlKd3l4NWZCN3lxODdZdU5HNHA1SFI1Qm45dkN4T0QvS2h5UDBjU3ZN?=
 =?utf-8?B?dGxjUktlYWpTdnNISlVEN1J0d1BWdVNVYURnVkNWdmhET1VNeWRBRVh6cCtP?=
 =?utf-8?B?Q1JRNnFyN3Nad0YvMUpIdnVNc3FpSTE1RmlKenZ1ck1YVmVjUUVUUGR0N2I0?=
 =?utf-8?B?R0F4UGJyeDlLbjhDV2NCQ1hHdER0UC9pcUoyZ3oyblQzMmhaS3dJUk9hTCsy?=
 =?utf-8?B?bS9MMlN1S0xOM3o3R0tyRzhGRW5ML29sT0xKZnBDN2ppeHRkUG9Da1NYQkhN?=
 =?utf-8?B?amRmUnk5d3Mzc2xMbEorcXdibWdreDVVeTNuZHhrZjFWbWdHV3FjZHJmUi9E?=
 =?utf-8?B?MHE3RDNnaWMxUmtLZ2FUUUVkeUo2MlRiTDE3aEFBRklUV0hMblZIRG05SytR?=
 =?utf-8?B?bnBWNy9oWUNBUi82cFcrMi82V25XZnIwYzZNOVVMenowU05GSHJtT3ZvSkVw?=
 =?utf-8?B?WHljc2J2SmRSTm5jWTlUOFhDSkR3VUxPU3NNMm1FV1RhRVNzMkNJTVRPVlQ3?=
 =?utf-8?B?ZGp0dWg5NVZ6Ym1udStkVlUrWnB3eUpZcVY3cEEwUzZ4TlFBaXdUVFFqOFNS?=
 =?utf-8?B?MU01Y1c5WVZicW5zcVczL25NNEt3N1JacGpuWTM1R0V1MmlnVzUyemR3c3VF?=
 =?utf-8?B?RmZKaTVaQjJPSERIcCt1VHpuNDYrbVRGV3NOam1zRjFFdDZiSXYyNEExVEN5?=
 =?utf-8?B?T3ZHM2kxUmlreEJPWWRBVmJ4OEF5S1JRL2pQSHBPWHR2WC9Ubk1sK1B0MkxW?=
 =?utf-8?B?YzNxcjQ0aklIN0xYQ3NyczVXYzFEU2xRbVcrMzJTeUtQZ2dRbTNNY3VncXhv?=
 =?utf-8?B?RWdBQnpPTGlCanV5SDBjWE1QS29LaFloVnpsUlBLNFd2b2RLWVRuMm1nUFJs?=
 =?utf-8?B?anhqbnhENm0xTkw4ellKM0tDRDF3MkRZUVJsNU1lTkl4VmdEVlVRN2FDZ0g4?=
 =?utf-8?B?c3IrZUQ4UmVCejhrWVpFREpnZlZVOEJzUzN6SFRoMmRVL0drUU5sREhzMXlr?=
 =?utf-8?B?ZmRSV2RhR0g5RlBYVTZBRS9BRmpTb0FjL09vaFVPamFRNDBQMUlsOENFVkp2?=
 =?utf-8?B?UHlnRDQwMVBhWFVYb1ZmbWNjOTBnS0w3c0ZESXcxQjVsa2ZxK1VHZXZUSnpK?=
 =?utf-8?B?aUxuOVdUODVKT3RiMDBqLzRWZHJNQzBEcndDdFlaVzVDb0lOWGs1djMvakd0?=
 =?utf-8?B?cENtVU9vMHcxRE1ybTh6TCtydDFQWDU0QVhNclBGZzVyZXpNbCtFbTlKUnph?=
 =?utf-8?Q?16hzEFFvSV3qdLwdCzvnLs38d?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c5e94a0-f96f-4b3e-7005-08db345ba8f2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 15:54:08.5782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pFuUrhcJM6FpSBDF4AJ8JiZFybKFpoP3oElqpBQIdR9ZkVyWkYE/OYCMHdsdRiFj3btI/d54uXMVW6pba7yG8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7999
Subject: [virtio-dev] Re: [PATCH v11 06/10] mmio: document ADMIN_VQ as reserved



On 4/3/2023 11:03 AM, Michael S. Tsirkin wrote:
> Adding relevant registers needs more work and it's not
> clear what the use-case will be as currently only
> the PCI transport is supported. But let's keep the
> door open on this.
> We already say it's reserved in a central place, but it
> does not hurt to remind implementers to mask it.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   content.tex | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/content.tex b/content.tex
> index 5057df2..f7446bf 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -2364,6 +2364,18 @@ \subsection{Legacy interface}\label{sec:Virtio Transport Options / Virtio Over M
>   
>   Notification mechanisms did not change.
>   
> +\subsection{Features reserved for future use}\label{sec:Virtio Transport Options / Virtio Over MMIO / Features reserved for future use}
> +
> +At this time, devices and drivers utilizing Virtio Over MMIO
No need to mention, "At this time".
It is always spec version to version.
And "current time" of the spec is visible in its version.
Please remove "At this time".

> +do not support the following features:
> +\begin{itemize}
> +
> +\item VIRTIO_F_ADMIN_VQ
> +
> +\end{itemize}
> +
> +These features are reserved for future use.
> +
Above line should be moved up before listing the features.
or should be written as
s/These/Above

like, Above listed features are reserved for future use.

>   \section{Virtio Over Channel I/O}\label{sec:Virtio Transport Options / Virtio Over Channel I/O}
>   
>   S/390 based virtual machines support neither PCI nor MMIO, so a

Reviewed-by: Parav Pandit <parav@nvidia.com>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

