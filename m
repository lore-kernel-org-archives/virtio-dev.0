Return-Path: <virtio-dev-return-12389-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 266E3C77B61
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 22:14:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6A9E929FC8
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 22:14:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 60BA498644A
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 22:14:15 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 55B4E983F7A; Mon, 24 Apr 2023 22:14:15 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4282C9863A5;
	Mon, 24 Apr 2023 22:14:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BTMELMaFyTz06e8kfzTvnQxcLOSQ08Yi7NaiZprDSpUvt1lMvascZ5nOj9PbJNpXNbNtaD76wpwwfkB1d5bg9obvLpXygZx3ttbIjLI5aGHvKsshjLUKLC2yT0CXQTPgbo3s8M4Vessr6AWYMSqcEOdzho8WyEaCGkBBRgU9YkHbpjnTxHo0fj6FwCqNI+U9awRew3kyQgsA/2W4BXC8Y1IJpV7Sb46DaaTzWF+BNfkM2azw9NIeEGf4Rtdq+kw6imJ4SDTXhKXrofTfxsdEyg/NHmMWOo4fUyspSLr8REt3ARG2J76bJ/Jb0mf2PXt5VAZwKha1hseHYt7907JwnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oHbphDiVMPhC8i60KsgTctCBedNvL7c0N3T7D2+mGBs=;
 b=hsV8jQ4zuWgRVkbKu8vasf7P2qEtYNg4cidDzmcZTTJ5XI28GyRmmqXui2piNL4LiD0YOP6XTHuCK+CZZDrnEjpUAWdwrROa67XiaJqsmjW1utO0O+VDttwXI52VE3sYC0We9sCSxKXLMyZzFKCbLsHO845rkogpo4/hKESWdpX9JEADchzwQ1sg2sYkaPa7rVDrAgs+QAugUBD+UuK8nLatIRO2ju5VHfhA4zBD1phT3PI15W+mpm78fN5OiWQ2M2sYVmsRjHUIvkU9HnXfjehq43fhzjbRGc46B6xjTRvXt0yYgOMgrr8M7MLiB/luAxSTd5fcpijMBZTd9Svo/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Message-ID: <a4b1596c-2132-714a-7557-fa5249a55945@nvidia.com>
Date: Mon, 24 Apr 2023 18:14:01 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, virtio-comment@lists.oasis-open.org,
 virtio-dev@lists.oasis-open.org, jasowang@redhat.com, cohuck@redhat.com,
 sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com,
 Piotr.Uminski@intel.com, hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Jiri Pirko <jiri@nvidia.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
 Shahaf Shuler <shahafs@nvidia.com>
References: <cover.1682354275.git.mst@redhat.com>
 <8a3435860747eeaa038ece4ff896c1cdd441c185.1682354275.git.mst@redhat.com>
 <5858e2e6-0b50-c155-85e9-eea6dfb533e1@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <5858e2e6-0b50-c155-85e9-eea6dfb533e1@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR12CA0017.namprd12.prod.outlook.com
 (2603:10b6:5:1c0::30) To PH0PR12MB5481.namprd12.prod.outlook.com
 (2603:10b6:510:d4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_|BL1PR12MB5945:EE_
X-MS-Office365-Filtering-Correlation-Id: bdf92885-034e-4425-5bb6-08db451137c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	e7ycteBOsWGHLhb5R9zXxLiAnoi+t4zQtYWYkDVJQOChlTJFdJ5B1/KjpQorUBLSrpZ0bCcErCwY5jKCmOJlX/KxCeLC3+Juk7HoIkibP0SK+dvP5n3yKdH+4bPtAje1NmTwEGyMIDQCfI8Rx+yFJFxKwVfxa0D0+uHpRBHsCocrdvGF9vow8qJMnWPOj0DrxA47Xt8VRsgHzl29xxVzsHrpPTsp4hcVClHLQFoZ9kJw+otS/i/8Q4+LXZcyyRQ0jRJMB6AhlEpvwvm8nUXNTNJJMDsJZXe3fVOFZdJDTEpwk2sVHrqkAV3vkTaHTuoNvjWYFPt6hqwEPaIF7Bkz+HxhLkX4FZ4upqaipYzBo/WuGWZJiLC5cU1PzUdfMvXetyfTN98o5XsyM2bXcX0LkFmBbxyrBanKA3tgsdcN+0rrOw4UoBuXVBMBNx9qjSwy19Iu061jpMnhvET3k6O+an9lsHP+6WXhx3C8cFhFsKrun5wir/Nu83pMrXgEE9dJ5XkpLANdgfEt9t8s7MzQ7qbqQm6XJpp2xQCWfheBeL2Yx2gisF5iZbcKyJSN8d2GGfFYloferJOtSgHPTruMqU8UIZ3otH7v5Knxe6zZSApxpWURouY5bNNFCsbwQWbUfGIVTftJcq+lEPR40GzsK2Tzh92W2r/5J/F5A4n+sSI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(451199021)(2906002)(66476007)(66556008)(66946007)(316002)(4326008)(7416002)(8676002)(5660300002)(8936002)(41300700001)(36756003)(31696002)(86362001)(921005)(186003)(6512007)(26005)(107886003)(53546011)(38100700002)(478600001)(6486002)(6666004)(83380400001)(31686004)(2616005)(6506007)(110136005)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHVQQWxCY2w5TTZsQWRoTlpQaU4zSURxV052S1VNVU9ZYnNTVEtobXdjbUZI?=
 =?utf-8?B?ekw2OHFVVGpPaE42ejBkVElmUGpxZmp3cTdFQ1ZIQStJMFJxVTZQQ0hYOWtx?=
 =?utf-8?B?NXkwVVR0bkdseWk2Y2JZcmEvSkcxbTJrMFhWTVRIMDNLSWVaQzBUR3p5RHN0?=
 =?utf-8?B?UFNQSnMxYUNndDEvNUNqdEhseXdqekJCY1EvRnZ6T0NjaGc3Mjc1Sko1bDJt?=
 =?utf-8?B?dUxiZTN6aWdJMEtwTXNITC9lZjlQeWFLMzgwQVRVRE92UjR4WCs5Zng2cGRS?=
 =?utf-8?B?M1E5L2lkMURpN2xVYlFiTmpCNWFNclJ4ZWV2ZUF6Zy9oTUpkOVM0c2xQRHJD?=
 =?utf-8?B?eUNObGNjYzRhQlQyTm9WV1FESWJITUp1MTZTVVEwYW9Tc2V4Qnd3NFRXSExY?=
 =?utf-8?B?TnRFT2txbm9CVDZoZVdzM0JvcitEK3UySmZsT3cxYlhoc1d5djhGS0h6OUtC?=
 =?utf-8?B?cEVBLzBaYXk2TnRrclg5b0VubithRzFwVFBnM2VzbzgrYVJrNHhGNkIxc01r?=
 =?utf-8?B?V0VEbVkycjQ3ejlvME9hZkY3WWN3TmIzdlZ4bG5TVlErTVNIek8wS0ZBbXQx?=
 =?utf-8?B?NElSS2VDZ01DNTcyTEM4cnkxVm9iWHhXWHlKNUp3UFFJUlMxTVpXRlJOTm52?=
 =?utf-8?B?TC9sTXBWRXdGUXpzWXUzNmRUZllaanRTSFdNY3FFb3MzdHA4U2U4MFFWYmlN?=
 =?utf-8?B?dzNTQm5xZHByK1JWblE3UVYyaVQ5aDAyUzVJbnpIR2UyNWNhYURZa1JucHU5?=
 =?utf-8?B?VlRPRUlHWUtRNC9HQkJXMld5a05YZXNaRjRqU1B6Um9aSEFoMmpTOU4yTzMx?=
 =?utf-8?B?ZkdROFh4b3U1QXplQ29TeVM2SFZEdW5mODRPSitoYVduVUpGTEVBYVl5MmZs?=
 =?utf-8?B?NSt5akVCdVZvZytrUDNNNkZxVUQ2U1Y5WUN5TzNoUXRIcm03eUNKQU5WU0lX?=
 =?utf-8?B?OU5ocjRtb3IyYVlXd3VsSXhyR0xaNGhjZ1NwOGVqZ01IL1VHSDRVLzlQdlgr?=
 =?utf-8?B?UWZPSnNBbWhTdFp3QnRKTVJOVFVFNUFWUUZyRXB4Z2hPN2dTWWd0azZHYzd0?=
 =?utf-8?B?SEhhcEdjVGIxSktZWTVJdk12bXkzYVdhSmZJSFZWMTBlSnhMRkg2SlpNbDdu?=
 =?utf-8?B?UjZ1SnFqUGlZRy8vRkY2NFpqVUFJRWZsS1FJdENRdUIyTHA2alNSQU5KTDhH?=
 =?utf-8?B?Sm1lbzJ2L0pHeUd5dTZCM1BGdldTWVJzMWV2b3FhYzhNU0lkVXk1aEpObTQy?=
 =?utf-8?B?ZVJUSnNycGE5eG44a3FoQzFOd0Z0eGhVbE1yd0hhTkgyVEVTVnhYYUFyQkxS?=
 =?utf-8?B?WHhUUkRTTG91dGxRRUlVSzZNaVhjdmF3TVdvWWVLTjg2cDBxTjU0TlFDSTRF?=
 =?utf-8?B?Z0V3Rk03cktkSE1pNzdBMmRyZGVqZmdkaWRvT09kWVhudUlBekZ6aFdWWXBx?=
 =?utf-8?B?TzdkakZLYVdveG5BamcxZnAwZVNYZzhBWkpNTU1IMjVzNStFSTAyRFQxY0Y3?=
 =?utf-8?B?WE1IRDVtK2lyS2ZYYWxzS29rKzFSYkFOYXdKVVlNeG44SFY3UEc5TzdZNlZV?=
 =?utf-8?B?K1BSZjBWK0VJQVk4eU9Jenc2RDAwQTdaYWVDSGJKd3Y0U2daSy9Wdm11L0pi?=
 =?utf-8?B?bGFVM3N5TUhaT0t4QnUxSUxOb3d1NkF0TmwwbXAwZ3RreVFpd0FleFZmWFV1?=
 =?utf-8?B?UTNoYWZFMkt0cHBFcUdONkdLakdVcnV0Vk8vSlVBK2ZpZm8wUWw4N3Y5My9J?=
 =?utf-8?B?THNUellPaCtqRGNnais2b2I4YTUwWmFjMm5nQis2Q09Yb3hrSnZGZllHTDFE?=
 =?utf-8?B?VXBUMHlUSXVYM2V4QXlDK1BKUGlIUXE0cUZSTGhxY1pWT0hoZ21POURRbnhE?=
 =?utf-8?B?Sy9HbGs1UWlqTUUzTFN6SFpTb3Y0Sm4xZ2p2SUdWTXE2TXJFNmZLNWJGb1RH?=
 =?utf-8?B?ODRUSFZES0Q2dklxYVpGNTFzYlZCSjkwbmc3eEZoMnlucWpCcFNnSnUxSldQ?=
 =?utf-8?B?RmhhckhRaWZsL3dib3I0Y296bE1zSCs4ZEdnUW5CRnBvaHE3TjVUNUVKMTRF?=
 =?utf-8?B?Z201dDFrYlA1alNqbU9CRnBrSGhLMlpZbjllT1Vxc1J0L1ViOFIySVZPZ2Jh?=
 =?utf-8?Q?wvWl/dFddpn5qNERLd0hjzyQf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdf92885-034e-4425-5bb6-08db451137c7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 22:14:05.7384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H+J4zKS+19RguAChuhQfJLfY+W+seJPqTSUjhLo6CvG0AAolBoJQorH75susK2JMbRPeI+teHkeicHR3SWUc1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5945
Subject: [virtio-dev] Re: [PATCH v12 05/10] pci: add admin vq registers to virtio over pci



On 4/24/2023 6:06 PM, Max Gurtovoy wrote:

>> +If VIRTIO_F_ADMIN_VQ has been negotiated, and if the driver
>> +configures any administration virtqueues, the driver MUST
>> +configure the administration virtqueues using the index
>> +in the range \field{admin_queue_index} to
>> +\field{admin_queue_index} + \field{admin_queue_num} - 1 inclusive.
>> +The driver MAY configure less administration virtqueues than
>> +supported by the device.
> 
> we need to say something about other virtq's indexes.
> For example, if aq index = 0 then for the vblk device the request queues 
> would start from index = 1.
> 
> can we address this ?

It may slightly complicate the device implementation when device 
dynamically changes the VQ indices based on the negotiation of the 
feature bit.
Also the drivers with and without need a different VQ index handling.

I am thinking that aq index should not overlap with the vq index in 
range exposed by num_queues field.

This also aligns to the exclusion of aq count from num_queues field.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

