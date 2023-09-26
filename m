Return-Path: <virtio-dev-return-13951-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC93E8181D
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Sep 2023 04:52:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3C08242A6F
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Sep 2023 04:52:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 16980986422
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Sep 2023 04:52:51 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id EB7F39863A6; Tue, 26 Sep 2023 04:52:50 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D754698639D;
	Tue, 26 Sep 2023 04:52:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eR2BO91VSd8NlML45W+aiI4CwLvk0P1i+BZl/fX9HN6gTQPy+EbRfTN3xUi5IJ6VZVMuJR/V7bQHGuRH9cIjOmWbsoYFmMcKjKCDnkw0YlquH99AoI8EwpGRAYaB/RyH943dg7b4nYm22xjm80/u1ESwx66aHmcLXqSwoFDS+YkpVtS7Bx05xFf8iLp+kc+8uv6GeipxjT5r7EFyGMjkGcsBUS/03iL1PxnPDuxsRQRuvqdTQG1bZc/oRW0x1/Famq2XR/JIwUJ3lfXnjDRn5ks57qwEwrUEbHP8kpWq1kG8zFdR/jyQkLMr0luW6KPhSmp5guhu86hd4JEz25SP2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NEYU5gLncBh4nq15LUnjbvMxBsC92S19jRXSl3ms3AU=;
 b=hLm/uY58AHzbhsq3MryHJVGCmBq3ufY4QnP1pA+9cqFC5U2fP0Jpn+QDJ0NgBlQTS/E7SOM6cvh3S7NiqNfUgwbw4OBfO0UeFNDriSHwaFgZKf2p1GCVkvgJcjqd0IQyzm9Pp90m7UUws06sV4H5y3Ncn8MJffytWCLn77Pskf5f24HNnyK4Gxubms0cn+AGPdFL/cZxiydgG29ci1OOskhEbOqkkUG/WCaDtHUnqTHe933jNH0FTiVxp7LGIorLwmwvYCcdlgmj+zdwjhslOVcuIh9X6jjIy0OgzvPIFWGVvN0kzBdrDK4bqgjjjCcIJsEVRZTPN/bsMK8oIP10Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Message-ID: <0f9f60b0-8957-4769-80a6-94a25604144d@amd.com>
Date: Tue, 26 Sep 2023 10:22:15 +0530
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Parav Pandit <parav@nvidia.com>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 virtio-comment@lists.oasis-open.org
Cc: "Mythri.Pandeshwarakrishna@amd.com" <Mythri.Pandeshwarakrishna@amd.com>,
 "Devaraj.Rangasamy@amd.com" <Devaraj.Rangasamy@amd.com>,
 "Rijo-john.Thomas@amd.com" <Rijo-john.Thomas@amd.com>,
 "Nimesh.Easow@amd.com" <Nimesh.Easow@amd.com>,
 "babulu.ellune@amd.com" <babulu.ellune@amd.com>
References: <80a2e4337affb043909c348395fb45aeeb693dc7.1695640593.git.JESHWANTHKUMAR.NK@amd.com>
 <PH0PR12MB54813F8968ABA023D551E05FDCFCA@PH0PR12MB5481.namprd12.prod.outlook.com>
From: "NK, JESHWANTHKUMAR" <jeshwanthkumar.nk@amd.com>
In-Reply-To: <PH0PR12MB54813F8968ABA023D551E05FDCFCA@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0208.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::16) To DM6PR12MB4564.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4564:EE_|MN0PR12MB5811:EE_
X-MS-Office365-Filtering-Correlation-Id: 08969498-e6e0-4257-b2d3-08dbbe4c6ab4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	g8bk95KJgYS3gtAZrbZ3fhtvcgw0ajPR8gUfHYxj/HiwWTLxd09dFiMsDvTtw5oteystzVhw6LZTPUr7MHElz1dvZZd7G+cZwGRllRF0vV45C86fK6EK6JEEuuczFsZq/YjFmgifEhb1To9++X87btjPHfy7ZiM+dyArQf2cEQXlR5fBgvGYnc+ylx25z3V1Zg0EU4LcqPAlxJEadz37ObDBbKIqNvf5nWCVQWprxctM08mLx77ZIESrm4hrcr082SA5317loK2GWfOp41rjN2RwjvfEn99kmgnwScutxYghuz6c4NHOOPxYPv1DVxagJt0pXBYbQRMa5xkjeJp8fGyjOSK+xadWXTM2aHFFpn21AdAy140b+1Kb5BIFXYQJiZzmFTZjdG/IZruV8yyTlcG+RcEnWsUjw68APmSpB0X0xB04aQjmaiqkSssQGzR3ehknIxPOIqOi1os6OmOhR+VSsifX7m11rjeYBFXM454xGND7rjpQMkjZ0hR0Pu0incMR48YmSrfb+c72S5eDJsNoxCOiIZJrhZTtIfl5p/Dx0im1HOAFw/dNkvjNlwJ5GgzOtIJkTe2BOnD2zGxHDYcRISg8Z1FgHlVS518rwXB1nBdBktaxElvit02lw/fEaVhcN1Zwj7wksLXqTpNQdg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4564.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(396003)(346002)(376002)(230922051799003)(186009)(451199024)(1800799009)(66476007)(4326008)(66946007)(54906003)(66556008)(316002)(5660300002)(110136005)(41300700001)(8676002)(31686004)(8936002)(66899024)(83380400001)(2906002)(86362001)(6666004)(53546011)(478600001)(26005)(2616005)(31696002)(6512007)(36756003)(38100700002)(6506007)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGFhYzIwaTA1TXA2eU9pUndXOTNDMG93UDZvb1d5NnQ5cENzTUZCNzF4RDBW?=
 =?utf-8?B?VzZRVTZCVWFPVW9hQVcvb3ZKSWJWS1o0N2hhRUJIZ2l4eHR0YytMcmpNZmRr?=
 =?utf-8?B?VFE1enJEUlhFcmNoNHVBVEZNeXhJSnQ2OGV3QlpOWUVndEtpYWo4TXR6d1la?=
 =?utf-8?B?YlovNUtaWWRDNWJ6UFNBb1VsZU5KZUFOVk5NVnhYWWQyZlBqR3Rib3lxYldH?=
 =?utf-8?B?VXlmRGpKSzlQUng2M0E3ZTBiZko1QVBCaHlpbTZVVVNtOGNma2JPZEltSjRX?=
 =?utf-8?B?ME5ENDFjKzVSNmthanBmNlRLTm83RUZ1NGcwWTg2RWVDN0VmeVdKTG1GR0Zz?=
 =?utf-8?B?YkRmWTdMaWVQd29aUERVRVB0N24wUTk4dzliYktjQzNRUmxzT3NpRXpNNE9s?=
 =?utf-8?B?WmoxZFk3cldrV0dsTjVqRlJTM1hxSTl2SjZNcUZlQVhWcXMrTTQ0d25KNzIr?=
 =?utf-8?B?N1A3bUNrbjU2NkZjbWxrcXVPZllmT2dvM25naURRT1lmUDc3dmFDT01OakdR?=
 =?utf-8?B?L0s0eEpCNTBXUWdhUGtjZ0xqRUpDMkx5eUc2UnFiRGhRL2RsdnVoa0w4bTdN?=
 =?utf-8?B?M2VrbUdOQVVZS1ZZUkZ5UmY0bTNXRjZpZWVOT2lObC91cTJMSURvU2hMek5p?=
 =?utf-8?B?RXJYVEFjMU8rTVV5WXVsZ3AwU3NoNC9CKzIyeVVQU3J2Q3Nob0pORnBmWVBh?=
 =?utf-8?B?YlpuK0hvSjdYNFk4RnpueHA2VEw3M0F3QzRyUU1SQmhCMFlJZGpnUXIycW1C?=
 =?utf-8?B?VmFxVXVtZVRJbXoyVVFSUkF2alROWDlOQXNRZm84WkdRcEU0Znh1M0lvM3g2?=
 =?utf-8?B?OStNM01OeXFxNU9qQkxiaEwvWlNnd0U0MDI0d3lpN1pZZXgveDFRVzZHdW1F?=
 =?utf-8?B?TjZXSC93RlFXWWRJM0ZSZVB5dzM1dC9ZZVJqRk5NR2t4c3ZsYkJpeVUvMWtY?=
 =?utf-8?B?SUV2eTRUTXJ1UU1jMko1TStLZDJTbFdPY0F1aXV6TjVGVldqNkdXLy85anB6?=
 =?utf-8?B?MTROUVFITGw4ejdSeWRoNWt3VDZPUXNOaWt0REJkQ0doUDNEYW5uREZmVTlP?=
 =?utf-8?B?MGFwaFJtTlVBb3FLbkJXQ3VVR1ZmblpTMEJzRFFHdnJLUXBMRlpaOS9CcWgy?=
 =?utf-8?B?Vkk0anVMYU1MUkN6YksrY0VRc24zV2pjV01ubVVUNnA0WWR2TDdpODBSdkRG?=
 =?utf-8?B?a2tDN2Iybi9ndjRoa3doRGt5ekNVZHJpRHAwSnZiYVF5UklnWHhKcUR2V3RE?=
 =?utf-8?B?YURFbFNONHBZdDM1WDUrcEdkUEk4NWJ2N29GSC9CZHlTM1loYUxpTkI3V1o0?=
 =?utf-8?B?S0o3aHljbXAvRnpWZ2dvV0dWRXEwcG5xeW9PV25Pa3lTSU9HS21EWC83UWk2?=
 =?utf-8?B?UlhyVmpDQ05ROVJBNHlTRkd5OVR1YzljbDZLTEN4Z1hLakRUekNUNEFXOWc3?=
 =?utf-8?B?MFZjR2FoaGlOK1o4VFAvMVhWS1prb1BwMHBRc000c01QM1BEa25KU0xoeTAv?=
 =?utf-8?B?NXE5elhxL2FVcVlGZWc2dWUyY2RHekFkZTBlNHlnV2Q1UU1iUXBwaVpjN3N1?=
 =?utf-8?B?VGVpSVZQWjliZXB0SktISmtZWlJrY2VhN2JVVFpoSjhteXBlcDVaL1NkMjEy?=
 =?utf-8?B?ZjJtWEtJSkxESkp4ai91RWY0N08zZCtPSlhRa1NNNXZ1T3E2OFh4cVpIUi9X?=
 =?utf-8?B?ZUZML2syWlpaWmtOdnlGZnU0MVFoWWhWdTUreVMzR3FKb0NTRmRLcSt5N3gw?=
 =?utf-8?B?WjVBMkJRQ25IQzVFUTFjMDlPK0dWRXgrVzNWSjVvWHNqM08wRjdKT21hWkMy?=
 =?utf-8?B?LzVCbGZCSFJTRHQ5MFlEdWJqSTk4SlQxN3ljRHlPZHBmWDMyMlNBQjRxS2Y1?=
 =?utf-8?B?Q1M3RzZzMm1DVXlJZE1sQ2FkL1NkcURWdHdsWDFZZ3pDL1ZDTnlFYldUTWJF?=
 =?utf-8?B?MDJVZDBKbmFQc1Rmbk1YQmhRZVpmd2VrdDFLcnUzOE15K2hkcHUvczJrcXNi?=
 =?utf-8?B?amtmVDlaSjY5YjM5UGQvQko3MmI4ZGhja0dmKzE0Ri8wWVc2eUJOdDZoVmZ4?=
 =?utf-8?B?bFYzMnh3Rk4xaytYZE9lV2NKL3VmR0p6UElFNFJKTlpLRytROWRucENENjFz?=
 =?utf-8?Q?L56v6vMBmf7YLym2WDT4CcWiq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08969498-e6e0-4257-b2d3-08dbbe4c6ab4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4564.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 04:52:42.4338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PqEhFeeXrramr4at4nLpt8jkWPkk47OvkXWamvKSsOLaHb/LWTwookZY8NpIPFzZ+P3Hjq5zNUKcscbyw652sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5811
Subject: Re: [virtio-dev] [PATCH v2] virtio-tee: Reserve device ID 46 for TEE
 device

++virtio-comment

Thanks Parav for the review..

On 25-Sep-23 9:08 PM, Parav Pandit wrote:
>
>> From: virtio-dev@lists.oasis-open.org <virtio-dev@lists.oasis-open.org> On
>> Behalf Of jeshwank
>> Sent: Monday, September 25, 2023 4:47 PM
>> To: virtio-dev@lists.oasis-open.org
> I notice this repeated occurs error of choosing the mailing list as virtio-dev for spec work.
> I will fix the OASIS document references.
>
> In the meant time, the mailing list should be virtio-comment@lists... For this patch.
>
>
>> In a virtual environment, an application running in guest VM may want to
>> delegate security sensitive tasks to a Trusted Application (TA) running within a
>> Trusted Execution Environment (TEE). A TEE is a trusted OS running in some
>> secure environment, for example, TrustZone on ARM CPUs, or a separate secure
>> co-processor etc.
>>
>> A virtual TEE device emulates a TEE within a guest VM. Such a virtual TEE device
>> supports multiple operations such as:
>>
>> VIRTIO_TEE_CMD_OPEN_DEVICE – Open a communication channel with virtio
>>                               TEE device.
>> VIRTIO_TEE_CMD_CLOSE_DEVICE – Close communication channel with virtio
>>                                TEE device.
>> VIRTIO_TEE_CMD_GET_VERSION – Get version of virtio TEE.
>> VIRTIO_TEE_CMD_OPEN_SESSION – Open a session to communicate with
>>                                trusted application running in TEE.
>> VIRTIO_TEE_CMD_CLOSE_SESSION – Close a session to end communication
>>                                 with trusted application running in TEE.
>> VIRTIO_TEE_CMD_INVOKE_FUNC – Invoke a command or function in trusted
>>                               application running in TEE.
>> VIRTIO_TEE_CMD_CANCEL_REQ – Cancel an ongoing command within TEE.
>>
>> We would like to reserve device ID 46 for Virtio-TEE device.
>>
>> Signed-off-by: Jeshwanth Kumar <jeshwanthkumar.nk@amd.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
>
>> ---
>>   content.tex | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/content.tex b/content.tex
>> index 0a62dce..644aa4a 100644
>> --- a/content.tex
>> +++ b/content.tex
>> @@ -739,6 +739,8 @@ \chapter{Device Types}\label{sec:Device Types}  \hline
>>   45         &   SPI master \\
>>   \hline
>> +46         &   TEE device \\
>> +\hline
>>   \end{tabular}
>>
>>   Some of the devices above are unspecified by this document,
>> --
>> 2.25.1
>>
>>
>> ---------------------------------------------------------------------
>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

