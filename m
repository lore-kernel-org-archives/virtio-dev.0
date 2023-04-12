Return-Path: <virtio-dev-return-12159-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6CD8C77B70
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 03:30:45 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 16C672AC51
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 03:30:45 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 00CB9986549
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 03:30:45 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E969D986295; Wed, 12 Apr 2023 03:30:44 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CC38F9864B3;
	Wed, 12 Apr 2023 03:30:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4rzRmGwlYB4QlfGaPHa94Kyleibx2MFf0w0+Ibp3bNzO1qlnm57kNJd++3CMe86N8yhVo22w9Y5pwr2b7qXphl7K1rErazjg2jJdmxsdKctJb8XANvnuF0gNwSgj7QBVOwkOfELmb61Qw8FOHOy1mTXrs7EEdXrN5letvmfL2XKgeg2/5qli6XyizU3wKppTJ+GVGWLj8uNlaqbabO4YGEuAAiFfhNrUbEpwx4VgE1EnilwbhpuMLQQRPxCvzeT6ZP5VOxH9LoICBonl1vWg+tlRqkUBAgxL5xH2GVigRwDG44A8OdF8e8DWqveEvp2PA1udhEjwggAzGPARHELQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8u46GCYQDL/aBWKQpxS2aRaiNYGhXYgSvAZzR/oencQ=;
 b=eeyQsnNEygwAXmYa7dUJlt8RspkMQ+U935cgPaqjRiu1grCUciYRHcL1TWWM583qFTtpihD2v5McZdlUGoo1Xf8LcFsRqGQm1GJjsDhczDQe3MfujQl/J/9gXcIrQQe2knqbzYnxM2nyGGEhXUVcrfXM+UlRbrEwjgr/SpAZi62k2C6NLdq0DxdBF0IJLrVyqXMPOfJPW/KS89IcWYMIUB9rAorqni3U82d/MLJusojRRB7WjAhb4B/vtwgO5JRLPjD3789IWT3Wl7+aJ91+tru8eGdTvuU1QddNRNN051SoH9wWOOIEATAsUwMHKRKvKwg5lW177REVv+g3VpZGRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Message-ID: <8f3b4396-bd4b-6249-edcf-6a4630c9a217@nvidia.com>
Date: Tue, 11 Apr 2023 23:30:23 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To: Heng Qi <hengqi@linux.alibaba.com>, virtio-dev@lists.oasis-open.org,
 virtio-comment@lists.oasis-open.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20230403045833.21853-1-hengqi@linux.alibaba.com>
 <569cbaf9-f1fb-0e1f-a2ef-b1d7cd7dbb1f@nvidia.com>
 <3638791a-bf64-7130-9c7f-6cb3597228bd@linux.alibaba.com>
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <3638791a-bf64-7130-9c7f-6cb3597228bd@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0071.namprd13.prod.outlook.com
 (2603:10b6:806:23::16) To PH0PR12MB5481.namprd12.prod.outlook.com
 (2603:10b6:510:d4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_|DM4PR12MB5985:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e76f1f3-2c56-4153-e826-08db3b06419a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3R/hA7F9pw7bbzZREbhKPjBVa8RC0z3VCex736Br94uGdYMYC9lNMiB7pvq6g5CkmFGQDBYd1Q/tZisfEdDtd6DVA396O3nRczFOY+Tfcy35qJ6X4zpLIiFbwyfl6NYCMi5HLUGLjZmqA0cE5nj8XJV119kfqzFiUs7p0eYniiy4J+PDIGRS6Im6C57/tJ92Xn+VdwcTQmx/RDHVTV4FwI6vLXu4O40uU2uXlkc0WN52lVVtCEU107oMwV/ax6e0fm62Wzl3sukiQ4Pzkxx1+gmSwd31O63hk6q1wg7LeFWVS33goj3gn8bDX6uPVDbWeEo9IN0z5b5iJ2cXbFR8+n9GccCkBO4fuaghlECM61Sax3duveUcJcz8lFeyYm3Ut0sUmVsk8SQKVUc9fRN0xKLdUGpqsr/GvXV3l1eSo1W5KNxjOQ5Ho6oH5qhh2DE5LPEC1yumkB7Gr0IWTjSMLHrsa+ukxx3hmrz2FGcj30cNBjSV/U3nTGmFu3w/cT46553lsBmzOmN9gnzGEVCoG38TFAs0HHFo/EKpGHQEujEcNPG3DkuO5/X42TgA1m0ZeHBuLkiGPqNBvVPmvvC5SfeKEtNR8rAAxHmuyf75TpyvzqKSZtHlfIVdC4URyJbaleMKsZQ6O/7TBhw/Y4FqIFzbg1LzAWH6bXt6OToKT4848ZB5tfkkPXNVPR9ahv4FRUYopksvahdkGdRI+ADVpQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(451199021)(478600001)(6506007)(6512007)(26005)(186003)(54906003)(6486002)(66556008)(5660300002)(53546011)(316002)(2906002)(66946007)(4326008)(41300700001)(6666004)(8676002)(8936002)(66476007)(31696002)(38100700002)(36756003)(2616005)(86362001)(31686004)(66899021)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWdodGlnaFQydmxmbW54Wm1aZEwzQVdFTmpnejVKMzdQRmdPbC9kYzNYQy83?=
 =?utf-8?B?aHNTVWtHUzMwczNoLzdJamZEZkliSjFWMEcrNWhab0pkamdOc2ZCbjU4N2Rp?=
 =?utf-8?B?UHNrVGZXeHdqVDVQQkI1NzU0N2lPaUJsSzRoNnBORkJEaFB3Y1REcGF0aWR2?=
 =?utf-8?B?eXc2bE1PbitmKzlrenMrTWU2TC9kb1hKTnpaQnFRQnZLeHRFWmNkRXFvMnZR?=
 =?utf-8?B?YjFBNXBEWTF0UWYxSFZFV0wwMklrZ1Z3TW51MjBidXJBUmw0a3VPSUVKUWtE?=
 =?utf-8?B?cDFIKzV3ODAvM1hERjlKQXk0OGcrZ3ZoRzIvQnBnU3FoNWl0QXRkSHo5d3hM?=
 =?utf-8?B?aXdPT3NGckhHakxWMk1ISjVXNHVwSkFTRmpaeGh1V3JHaXZSUVR5WHdCanZH?=
 =?utf-8?B?aGVuSHgvekhNMVE5QU9QS3FibnNTTDhMblY5djI2TTR5NW8yaUNZOHNOMGtj?=
 =?utf-8?B?cFpna1IyVzF3Vm1TQkVRZ1lNL0VhY2RnM1AyQWJycEJmMEdXbmdVOW80L0lh?=
 =?utf-8?B?Yk1UTkQrdE8waE9mL3B4YnJNR3NkV1JpT0xLUGUwWnBhYlBrNUEvazFUWFJr?=
 =?utf-8?B?RHhLbHU3aEtocVdKM0N1RXRXOFQ5NUpjcUVBNWNDekFOZ3lhamh4bExUZFVt?=
 =?utf-8?B?Y1NLVXU4RlQ3cUpyaFNxOTlyYW5XNjhrenJ1S0tKOTRZdTRUelh6T1lMRFRm?=
 =?utf-8?B?UVdJb1E1cllkZ1V3Sk5sUTV4MTRuUVhMMWU2MzZSekNBYnJuUDdQSnJHZUVp?=
 =?utf-8?B?elZOMEVoRDFrZUQ1L0MwS1FZSWNUamZlVzJZU1hlVWF1aWJJeEh2dkZ6WVVF?=
 =?utf-8?B?cS94cXZmR2J2L01uSzlYV0hVWkwrR0J1VkZ6Yit2SDFpdWZoUkIxc0RneWEr?=
 =?utf-8?B?WWdWUThCSjVXTVgrYXgzV2s1S1VYRkNsM3dtQUJoN1p0L0ttMEw0Q2ZVZkl3?=
 =?utf-8?B?N0l6L2M5aVk2aEdVZnV1MXJONkVKVHFoQVdBRnYvRTlLNkp1VHkxRVNjZHVM?=
 =?utf-8?B?c3R1dkp2TFJySUxKQklxWmtFRlhJNk85SzIxOThLM2tPTmhZWVZGT1huNlU0?=
 =?utf-8?B?OGZTNWk0VjJKUkJXd1NMV3R6Q3lXeDdxSEJPUFJ1b2RsdFVJbHdQSmVvODBF?=
 =?utf-8?B?R2xhRXZvN01jTDNSeXBrMFBWdkNxSFIxYlFRb2w0bHFDTWw4YmVMZVQ4TUNH?=
 =?utf-8?B?VW9hQVNiNDlaQWFueWVRV3BLWFBzYzVmSGJiSWlEcDVhSnRTVEhwdm9NbXdr?=
 =?utf-8?B?QnBhZjNaZm85YUh1ak5OS25NNCtENkRkcmNvVUR1WU8vQ09taGFVZ1lyOE01?=
 =?utf-8?B?bVlOUFRnTWRXdGY4WCtYT1ZHOVdmQldyNVV1VDE0UHQ5eVFtRHJZeG1XNk5C?=
 =?utf-8?B?NkNsaDh5UlVoMUtNVXpvdCtkYWU2OHV4MG9OcU9jVmgvODkwZDExT2l1YjMv?=
 =?utf-8?B?d3BVcWtoeUgvUWdtNUE1Tm03YWE5ZTE4Wk8zVFpmd3hITXdHUXZKK0cvNUN2?=
 =?utf-8?B?R2krcUQvRFpNVjNHTmtqTVYwandSSmlpUVFTY25FWGtxWnptWStNbFp1MURy?=
 =?utf-8?B?MDhTN1F3b3dzUVg2by95UUpwNm41WFpiQXNNWmd5aTZPZkJ6K2dYR2JqVnVL?=
 =?utf-8?B?elFiV0h2STBRejZPeXdES1ZsUWpXZ0NLYS84MXlJRk9wVW5SNEpnVnQ2QjRV?=
 =?utf-8?B?b29UbEtiV3hkRmpWRmxudmdJVk9yRVBGUFFpbjgvSHdEdDZoRmU0ZGtZZjFu?=
 =?utf-8?B?QWg1akdpTnoxSWdGRm5HNTlsTzlyYk1LVlhmUVdoUWoxWTVxamYvenRveFBI?=
 =?utf-8?B?SzNiTGlOMjhNTnBJbDVibUROdkRtYW4reVJnRmE2NXJyTXMwLzBSNWw1cEll?=
 =?utf-8?B?bEJwTVhuNXVtN0RzTnFKNndUbU4rU2FaRDZQVElQSzZjRjh1cGk1aVpTSWlH?=
 =?utf-8?B?R25yNjFWUDk1VHFmQkwwWmlNaXdXL1F1MVpnYnR0bE5XbjFMWk9JNEFPY2h3?=
 =?utf-8?B?TUlHUWpFSXRNd1F6RHVmK3p3Qkx2SGYyczdYZTFoSzRadEMwdVIrODV2MXFL?=
 =?utf-8?B?aFNZOWVpb3YxYTFFRGl1K0NQZHFLUnhGejluQ0thZHM1Y0VTTitpV0lldjNu?=
 =?utf-8?Q?Q/fOICSH+H2ORM3yG8TP5kBDR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e76f1f3-2c56-4153-e826-08db3b06419a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 03:30:26.1667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nvpk2XXk63nB6qz9Mh2EKyahzx4RIOd2Ir4zFktyU2TYIr294EPIacXaMChCFV8wkhE03oDrMJLueBeO1D9g5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5985
Subject: [virtio-dev] Re: [PATCH v12] virtio-net: support inner header hash


On 4/11/2023 11:05 PM, Heng Qi wrote:

> NOTE: We only have two modes now. The mode is not equal to the command. 
> We can add VIRTIO_NET_CTRL_MQ_TUNNEL_CONFIG for commands, but there are 
> still only two modes:
> "
> This specification defines the following modes that a device MAY 
> implement for operation with multiple transmit/receive virtqueues:
> \begin{itemize}
> \item Automatic receive steering as defined in \ref{sec:Device Types / 
> Network Device / Device Operation / Control Virtqueue / Automatic 
> receive steering in multiqueue mode}.
>    If a device supports this mode, it offers the VIRTIO_NET_F_MQ feature 
> bit.
> \item Receive-side scaling as defined in \ref{devicenormative:Device 
> Types / Network Device / Device Operation / Control Virtqueue / 
> Receive-side scaling (RSS) / RSS processing}.
>    If a device supports this mode, it offers the VIRTIO_NET_F_RSS 
> feature bit.
> \end{itemize}

> So, it is not incorrect that we put VIRTIO_NET_CTRL_MQ_TUNNEL_CONFIG here.

Got it. I got confused between mode and command with the text

"The command selects the mode of multiqueue operation, as follows:"

But its clear to me now.
Thanks.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

