Return-Path: <virtio-dev-return-12524-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC81BC77B7F
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 19:38:46 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 018582B139
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 19:38:46 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E8DB29866B4
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 19:38:45 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id DDDFD986594; Wed,  3 May 2023 19:38:45 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BFBF89865A1;
	Wed,  3 May 2023 19:38:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jGX+/fyPIzNtJLbC80XTW2/S4OCwsoMu1yY8mtZixvSLu+zn3xu+PAA+Eg5x4e9biNZihQyTg1fBLX/nY0SId8LUfPB7j+U7EzR6QNlNqZRPI+i7nlIXTspxtoyO5VWbq1W36ZV6JKDxH6PXcDYY0aH2LBUTFkADUHyefQ+hvpdyhgfrI7lA5keql84iGnowP3WkUczgnu5D2/2aCCwmigHGTWiEOlj9HMZPtq0z394TEglD8PYsfo8SdhUGivq/K/a5Zg/lxX3hV6iyK7us4HaFz2OMHbI/Y+XilDeyTVMwvzcNPb+HDxU3Ddqh7iO4Qw6qjr9a+JSKgb/HQ6m3qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rp+2hkzz012WNDP6r8Km98YQJkAlbDnqYLL2YJp7XAw=;
 b=f62WQP66LGG7SGneYmgetVQwgY5JDy4pS+Mz/jhHWBPJRTG45y2V3Y6ftKIxTwQiTofzgOvta5OvaDnSxb5Bpedqc2TrPvNtPQDlF4wQXA2ji0FKHXEAXTX58hpc36eej+bXnrI54+rcP3UutZxVDcjDjDQL26uqxftzxhbXRU8Yf0zuvNTbRtGvyweX8WBYid+n3Blwcsk1CFUfsCIQGhvm8MU+pVadCbX3dt+nvDVYmbtaIo2ZNM0AhPrQmRemFSesBUeNl3RubPlTTgUoLsf+C9TqqGjWoLQVeGoW0YdbWCFEVok0uAYoYyGsK2dEUFWLvzp1hvePLfDWNKY/EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Message-ID: <8c9edc69-933a-9202-4495-ef60e2f93c5a@nvidia.com>
Date: Wed, 3 May 2023 15:38:31 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "david.edmondson@oracle.com" <david.edmondson@oracle.com>,
 "sburla@marvell.com" <sburla@marvell.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 Shahaf Shuler <shahafs@nvidia.com>
References: <20230503032659.530330-1-parav@nvidia.com>
 <20230503032659.530330-2-parav@nvidia.com>
 <20230503151908-mutt-send-email-mst@kernel.org>
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <20230503151908-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR08CA0024.namprd08.prod.outlook.com
 (2603:10b6:5:80::37) To PH0PR12MB5481.namprd12.prod.outlook.com
 (2603:10b6:510:d4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_|PH7PR12MB7113:EE_
X-MS-Office365-Filtering-Correlation-Id: 130abdc4-f62e-472f-a0c4-08db4c0dfbfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eBzxQ9abD1PBk0cnIowJwpInFZpNnWfGRXId4mVTLmn8ZKXcDELYim8dJZ3SYnkjMxUR7IsJdqdA6/Jl1mFwJDMI9jBie7rivAlVkP9qf9s7oFTQVZ6xhshCiQzlmWWCMFWk63a43fVTRpct9/O2vTd8sv5SPbNuNvzM/zaBcWIqAcmpDq5NgvhGsKrWuolGfDIHuMemYjy6RqcZoBZNQ6C1YNm6V8k8IAcd/+lekl4ogyRXaNpyQ8QDKRsKzM+Eso/sMgr5zJyTFbEGTMLn9EKvt9T9t2dqYLq7x5ML1IIc2Eox2GNEOkvqMomJixr4BIqY514zkijgeXJUQfmHsMwdOqXWu2OyNKUT+7HRaE3Crwlby4pIjkOj/JJDKe2313qy9ppavmYF6vkz8TiuW9QQrLFnVoTldYATSqyKS22ZImySf5DZwtAXNMmKe/FI2UbGoTOXy8u6CyEhuQG80Pg9qO1WWmTcMysULq24mlMrHCnHspjx9/gPp0KIWexSqQO8ktouDWYKt4gVfx/+BnKtDZc6aplt5nFq/N/gPWW3nOFjZXGud9D7YLGhgsFHasH4CqO5z6/wO5sWfxopE0xa1D3AYu5X4ZEPnlaae4PTwxozN0ZrZNskWfjrUzfuAKu9szt8K5H3zlCdowMIyA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(451199021)(6666004)(38100700002)(31686004)(4326008)(478600001)(54906003)(186003)(6486002)(83380400001)(2616005)(316002)(66946007)(66556008)(66476007)(6916009)(41300700001)(26005)(6506007)(6512007)(86362001)(53546011)(107886003)(8936002)(8676002)(36756003)(31696002)(2906002)(5660300002)(4744005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3JFcldBUm1ZQlpsbU9mUCtWaktQSWIwT0NEeXpmS1NDQ1VJUGo3TFRsQ1Ay?=
 =?utf-8?B?WVhDK20vbUlhRElSOVhQWnFjdmhsKzI2Zm9jT1JDdmFzS3RTdURFRjBxcjFJ?=
 =?utf-8?B?TkRtaVRnQ2pqS1VJSVRWYmI5SWxncmYxc2VrclR1Zm96Nm5NTXZNTTVFanFO?=
 =?utf-8?B?dEJqR1VYTWxPNEh0RkNWcTVhd280Sit6QVZGVU5wOWE0UUZvQ2J6bzRjcGtl?=
 =?utf-8?B?eVVHem13ZUJsYkRNQ0hJbW5XVmJ3UzE5YXk3dnVpZTJFNDdZeVAyaXUvT2xh?=
 =?utf-8?B?a0srUk9mdWVUa0h0UUYwK3JHZlBzeEtQdTd2U2ZJdzA1T1gxUTdTQ2xEMmNU?=
 =?utf-8?B?WkNYZ2tHbXo2Rmttck1tTTlaM0wvcVh6bVZHMlMyUXNFU1lSTHU0Nm1mVVFR?=
 =?utf-8?B?Vy84YnE5cDkzenIzVjBkQUdDdmZRaWNzc04zR3ZBTk05ZlRvZm9OWUZWVDkz?=
 =?utf-8?B?SEJqa1RFNnlOc0NFOS9saWxSWkJaMGluUXZFQXBCeXcrNDl6RnBydzEzNC91?=
 =?utf-8?B?MzNpQk5ucEtNT0hIZmV5dGpjU0JaTTBzZ01tL1JMN2lMeFFuT1NyWmU1eVFO?=
 =?utf-8?B?ZWloem9LYjIrNEwyaWJPVElVbDVkb2ozUlNBUTZ5Und4S0t1cGVPTUdHc2N4?=
 =?utf-8?B?R3UrT3hZbjNacHVYVWJvUVZGZVhlcUlpRGtXeWYrR2t1dTRqdUVRVk9mYmZV?=
 =?utf-8?B?ZEttYjRoQmhuWEhmRXBzSmJHbDFRa0QrWngzNmRrbkszOVVWOUtXdzVhWDJu?=
 =?utf-8?B?OGw5cDVlakJRVnZpQzhzRUxaS0FlM21EZDY3dUltNGhDaDFwam4rdEw4ZC96?=
 =?utf-8?B?RHJBdmNxU2h4eEx5Q0hnOGk3a2JqMUoxeVAzZG0rd01IVTdSYTI5ditNdS81?=
 =?utf-8?B?UzB1dUdPbU10UlNLek5QRVpwRThVb1d1L01xSjFsczBFT05jSitvUFdPVU5x?=
 =?utf-8?B?VW1ydTFXRWJuMG5aU21DZTg3Tks0anNseC80ajQybVpkMWE1MWNuN3ZhRzlz?=
 =?utf-8?B?d05HNFhXSnhkQ2VvM0V0NWhLSlI4ellNRUduc09ZV0RFOVVzZDJ2aGhxTFEw?=
 =?utf-8?B?TE5ITEFVSDIrQ0dmVDIxeXN2SkRJdkhWU1p1MlBrV1hNSmcyZmdDSCtOWDNM?=
 =?utf-8?B?T2hkVURMN3ZVbHcxMG00YkpxdXNLTXFxQXZZZUlrMm80SU9NVzBiOVZKY08r?=
 =?utf-8?B?NDk1VSsyOTRGbDVSNjRHOUg1a0hReENPYlNXYnNyQkVDWk42QXFNaVhiNmVu?=
 =?utf-8?B?MWM0NWxRQTRJdHBEelpud08vME5vN2ZxMjZBekVkNVVGYzRCYitQT0hMVEJY?=
 =?utf-8?B?UDNmRGFkNDV1NC8ySDFMV2ZldVRRRFBXUWRoc2FOd1oyQUMremMyNWNFeHhq?=
 =?utf-8?B?NEtRU1RtVXAvbXZIZmdycmVibU1XZEFFY3BVZ2VXRnBMWWxtMjBtTmg1NlFX?=
 =?utf-8?B?Z2VnVzJ5VGdHNEpRRkFMMkQ5TWpUTzJOdjZXbDBwMlNPNUFmcXY2VG5nY3F5?=
 =?utf-8?B?cUxQUmF2NGczRWxoOUxZUkJ0OGNIdzBnRm5kdVQ5RFN3QmtVbVRjaFZsdUpF?=
 =?utf-8?B?eGhybVZnK2xQcnNkS2hQbzBwVmJkdmRITmdNMHEySVVjQjE3TUloNHRhZHVE?=
 =?utf-8?B?dlZGbXJ4aVRUaWNCT0g1ck0xWVdCRmFSVzJqYU0vODhpc0Y0WWIyTkVUdnhC?=
 =?utf-8?B?aERNV1k0eWdWNDREd3dvdmk1NzdaQ2QrYlVnd1ZyazJWb2xzVjZzcHR3WEVQ?=
 =?utf-8?B?UzVobWxOdy9Nb3dYYzYwdzFFenozeHQrRzhIS1BCbDhhcVpreElNWGsyeXFu?=
 =?utf-8?B?dEp5bFR3VkNvZlBOdmxVRzF6NjV6d2ZpNzY3SUNKd2pDeG1yQWhTcEJ3VzUw?=
 =?utf-8?B?c2dTcUw2VGZFZGhVZ1VUUHpUZDF4THpaaDNXRzFsNHJzbE1BNGEycGY3NUtD?=
 =?utf-8?B?L21Gb05uZ0kvRE9pWCtseXJFSWRaT2JvTThUTmxHb1J4RkRSMS83dW11Mm4x?=
 =?utf-8?B?Q2pFd05Nc3FKc1dGN0NicW9nTWxQY29oRGUzWkd1VHc1SEQ1R0djb3ZyRkI1?=
 =?utf-8?B?REUwOVFhZ3RvVlJKeXNiOUVXSXg5cDEvNXBST0xiOUM3UHVTcTNRUDZ0U0Z1?=
 =?utf-8?Q?mH5cEMF0jlPCZu7qBdZPvjslf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 130abdc4-f62e-472f-a0c4-08db4c0dfbfa
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 19:38:35.0897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ca9eDXpVw2oW05QHu+vnxGhAKUqQwBOfDlFGNPSgv93Ugubgrr9k7Q3AQhkay6hX79hCxDDHIgTM+OQgQmS65g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7113
Subject: Re: [virtio-dev] Re: [PATCH v1 1/2] transport-pci: Introduce legacy
 registers access commands



On 5/3/2023 3:21 PM, Michael S. Tsirkin wrote:
> On Wed, May 03, 2023 at 06:26:58AM +0300, Parav Pandit wrote:
>> +\begin{lstlisting}
>> +struct virtio_admin_cmd_lreg_wr_data {
>> +	u8 offset; /* Starting byte offset of the register(s) to write */
>> +	u8 size; /* Number of bytes to write into the register. */
>> +	u8 register[];
>> +};
> 
> BTW if we don't have padding we could reuse buffer size and won't need
> size here.  
Yes. sounds good.

> Do we want to tweak admin command structure generally to use
> u8 and not le64 for command data then? WDYT?
> 
yeah, cmd and result be u8 is fine.
If padding is needed for perf, may be that command can define the padding.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

