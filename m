Return-Path: <virtio-dev-return-12600-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBAE4C7EE22
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 17:27:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 16E2671C8B
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 17:27:03 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 068BF9866D7
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 17:27:03 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E9F0F9866C4; Fri,  5 May 2023 17:27:02 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D5EE19866C5;
	Fri,  5 May 2023 17:27:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bM0UdYSE5gq7O+pyvXYcXaE5SP42y6MdsiXmKVcQmOqIZJ36V5yixwWFHFjrezTE4C1deiM/9RZcyzP+awBOR2QHdsSt0StMk2I2H2GtyCf8nkzivv2pdZkMDt35e36kyzN2whiXis2JPhQQXwrh/s7xBIxWtxcYv2mSumAdRAfmTduIRFHQAjET7McBaRJnDPJ+QPzOKx/dKtpwN8Sh/QbJsNX9TXgUonUfKtdzJUHQRrfi6R54I8vz+dp8tpI/aHTNI2Jw1wRfY+0KR9Ly02/1S7B7BYGMbsAy7KMp86lLH1wWim05WQPW/xszHUh2shzd09k3QAbFSkvXghm25A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZkhzNYOUaayJcWJWvqNYFFSZNhTqpxNDF/MmdYO1I0=;
 b=ic1bRBbmVdv6hitkjFgUWZ7O0cHF4B0/3w0WbeAzCJS98DpNk3CgK7xtoqeBOl1RbCimh8IYTy724FuOmfY+6XZFbgJ0PpOZpRt7jo57gpIMnty06TV42YkWHpj+WmiCdsukMlJy82jyZt5R3zDdyO2BNTay2C3rzXNFutXkDs75dd1twZd7w1ywnRWjHI5j8T/0T5D4ybp16DCghp5sbvT/wru9ILWOFHTnrA2hPaM9N+W+/aK/Hm+H81IUTXNnYEWofmHnBdpu1q8D3l6BwJ9i2IMgnok5ceXO0qdmpX/WLLovLwtz9L7VF+f+V4ZOOoRFLjWUZii+gJvX9zrLjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Message-ID: <e5100682-bca9-b4fc-c701-b02c8880982a@nvidia.com>
Date: Fri, 5 May 2023 13:26:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>,
 virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
 jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
 stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com,
 hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Jiri Pirko <jiri@nvidia.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
 Shahaf Shuler <shahafs@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
References: <cover.1683301091.git.mst@redhat.com>
 <9848a0e23c02cfc4ca03bf72e37860578c58b18b.1683301091.git.mst@redhat.com>
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <9848a0e23c02cfc4ca03bf72e37860578c58b18b.1683301091.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::16) To PH0PR12MB5481.namprd12.prod.outlook.com
 (2603:10b6:510:d4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_|MN2PR12MB4143:EE_
X-MS-Office365-Filtering-Correlation-Id: a08be4c9-7125-459f-3861-08db4d8deec8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ncs+t2RLMNeDbrXVyWTYk4v7Fzm2fKdGXSn9HW4bWTuRaMKcATlfo5nS5tMlEdn9sZJ5BvbE+W4GoArLPqwZCRHRJWozwaefN4TC34TdrfGEzMAW9HUKv4GMbEsto7Bwz2g6pk1qCKBK0s/7Y8IFoUoawcG/j0DDWb/kbwoe0/tph8c0Jme/f4mj/jj2t1WTBi0YCiwd6IdLHe4XQ6BBsTpRxwvhxOZrZz2boXhX/KnTqCa5w55jUeMh4Poga3unvvmJ9pDcAw18qUw8MqThLd5gI6QqOIKkwQLm8+L5YAhkEivcgX5NVMkiYw3rOu3m4bBurJRJZaOgJCmeDgGxu8+ZP7T1BlWVlXz4Scnhsmji5yc5Up3wTyqxLZmAlYoDr7/tT9OftLn733ur09Rj89D8rmL3X+rCMxtHYWTqMtDx9s83DG2sMZmA72udMnTywOn+iwAhUotcyygumyIPLj7/MjZRChGM3PL0RBv4Zb2ReEN21BhKzcvMErve9fJLWcMgm/W5cV6yGxQ8UNGbU8Yma31dw2K3Xgovn5YH2QUMJQq9pPRBDyTEl6MbbB1VRZpYQQ9eDDaF7OWyXp5C/bnUYytCMNoUhirVgFqM2gPsqo92Yub2rxhNederZmTbkVXwCuwVqsfxPlxJKeehq+M2sf7xtzqQ79fsLQ/SBVk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(451199021)(31686004)(478600001)(66556008)(4326008)(66476007)(6666004)(6486002)(66946007)(316002)(54906003)(36756003)(86362001)(31696002)(53546011)(26005)(107886003)(2616005)(6512007)(6506007)(4744005)(5660300002)(8936002)(8676002)(2906002)(7416002)(41300700001)(186003)(921005)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXQ3REpuaFltODlsYklDSmxZSkY0ZlN6Z2Urbk1DOFJYalRFSmhlZThVQ1hv?=
 =?utf-8?B?UVlVd1B5dnVFVlZXWXdiK1d2U1VkRVdQMUFnb2gxQVQ4dzUraGY5R3hvWXdh?=
 =?utf-8?B?QXdzdzhLV29STnFvVG9KTCtFVFh1ZlFacVdtaHFKQWlmRVNyYTJaTko2RlpC?=
 =?utf-8?B?dG9jTkgzallDK1lYWlFaNjkyYWRZY255aDdrTmVCOEljeHNuYjlBR1NpeU9W?=
 =?utf-8?B?bVB2Y1N6dDB1NGsrNTlFM1ZQVmFiNC83a3dNR3FLblJpMEhldEt0TzgzSUZy?=
 =?utf-8?B?eUg4SXlRdXF0V092dXlBazArSlppa0pmTmdUU25sZU1FVTZnNXdoRldMTW8w?=
 =?utf-8?B?Sjk4Y0pKOFpSdWhvblRGTlovVnpaVmJHNHhaTGFoMmN4T1RUZHc2TXhyRTFa?=
 =?utf-8?B?YzNYM25YL3hYOUlMM09YV3U4dW1JcnNmZGRLTjdKYTNraVpaTzhaRHB4R1JQ?=
 =?utf-8?B?eWswQnIrNjBHQkdlWngwcjRDdzV6WXUwUW0wYXBWQ2JxQlAyMWFUaVZudnJ5?=
 =?utf-8?B?bkZVR2RyNjlxOE1xaU9CTEdBSEViRlA0VzlnYSt3NVIvWUhxVStBRDI0a3cz?=
 =?utf-8?B?ZjNzTjl0N1kyODBYOGNJcnloMGZnSWlqeUQ4b0ZnbWNtdGtSaWFweG9OY0Za?=
 =?utf-8?B?cUZ4N3R5RUtqZ0UzZXM5MXdLRXB3ejhDL1hZY3hYSlIvdDQyNTdCRUlDTDk1?=
 =?utf-8?B?ZUM5dHRPTjBtNU9IQlVsN3VmY1YydllNc3A4MWFKUG9mSml0RDhyZUVYVHUv?=
 =?utf-8?B?UFBiTmxjL2d3Z3gyUnEwTXhFZWhqUEU5UHdCUkVjU0o1TFVSVUtWZjN5MUEz?=
 =?utf-8?B?VlNMM0swdy8xdGVMTEdYL29CN1pDN2VBUFNZUm9JS1hoSEVTT0hBOXRqYU42?=
 =?utf-8?B?MjBTTVFQWDJCaU1rQjMyN3g0UWhYTnJiT2svRW1hSFV0cTBnaG9vd2RvS1NJ?=
 =?utf-8?B?eFNSaUFvR1hwVmI5R2pCTmMxYTNucG04cTBYZmpzbzNXY0M4RVR5aEdyem9s?=
 =?utf-8?B?M092N2dhbURlSEZzOURxRkhRRURzZVNObjN6NldmMkxJSnBkQW0rZWtTczhS?=
 =?utf-8?B?NW52UHlKLzhwN3RjQWJtV1R4K3E3bmNmMXZzSld3RGVCZ0MvU3JEc2Y3dkJw?=
 =?utf-8?B?aWc3VVpibDBsZEU0cjJNUVpqOVZvQ0JGU2dOWVJsbTNjK3kwM3kxZWMxb29N?=
 =?utf-8?B?b0NLNFYwSkhQWFdEVXFCOWU0STltYnJBbHVMdThIMGtYOFJKNXg0bXZ4TUhG?=
 =?utf-8?B?MHB2cnBwdTRycGRqVnZCckFON1RScG82a1VFdFlzM1l2b01JcFVNUXNBMkVE?=
 =?utf-8?B?K1Roa2dRa3VVMm1wMmNFWXNZYkV1cGFOQVlqSkhMVW1GS0VZWmFJY0lkdUpx?=
 =?utf-8?B?Y3dHQlEzSzMvb3NRZU0zSzlORHRYZzJDRFVtemptVHlLYVNBRVlEbTJJSXpN?=
 =?utf-8?B?R05ldnlMaVdHWWJyZUZCVW96cWswRC83TWREUExPSjlDR1BLdFhob3AyZ0xG?=
 =?utf-8?B?TU5tMmI1TEh3ODZ3Z3UyTVJrWWt5V29FZTBiZmxjV2Z2dDhGbkdsZktJeHhm?=
 =?utf-8?B?ZEdqck93YnRIK1VTU3lLYlFpQVNhVWJPOWtpQTlNVkc3Z2cyZUJsNDNubnJP?=
 =?utf-8?B?bVBqcFRMNDc3UUpXelEvRzRGR0dzUFZEZlVEOEttU2cvQ3c5d3RMU3pnR25I?=
 =?utf-8?B?VFJ4bExxdDJRaXJpeS90ZE52alh3TlBxZlgyblAwSFZkcEttOFlndDlnNC9z?=
 =?utf-8?B?aGlaS212YkVsc0I1ZHFrY2dxcVhRRlpMekdDKzFPT3lpajdtRnlNSzdMT1lT?=
 =?utf-8?B?eTVQLys1ZXNScDdNQllRbXBUY0lHUnZGYjRlQitIeTEyY2xUMkhuZlhEbXIw?=
 =?utf-8?B?cUdSMi9sN0VtWllJMW1ieWdja2xwUTJEQjhNMVA2ZDhBYVRhZmllOG9wajV4?=
 =?utf-8?B?bEVoRUwzWkRLUkQzWkV1Sm9Cakc1bUQwNVdpYUsxOUdVcEx0MnprUmR3TzEx?=
 =?utf-8?B?d3psVnFWRERqTHJYZytvZ2lLZklnd2lIMkd0VjBQZGpNd3F6TDBKbHVBTHpl?=
 =?utf-8?B?UHphdU5FMUlaK1JJOXF4c3NIeGx6LzlqZFlpU0J6QWVFYlVxOEVPM0trNHpq?=
 =?utf-8?Q?7ElTVn+CNgdZ3QEwk+kx1LxSY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a08be4c9-7125-459f-3861-08db4d8deec8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 17:26:59.6457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nY/eP7vPAc5C2kuDB3tVb5ZoTRDXnA1BQBtrmwsJDbOn7iSzGlEGB7Dx8eucb3+Ox1NIudVuG/ZzKCs3DAC6Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4143
Subject: [virtio-dev] Re: [PATCH v13 08/10] admin: command list discovery



On 5/5/2023 11:41 AM, Michael S. Tsirkin wrote:
> Add commands to find out which commands does each group support,
> as well as enable their use by driver.
> This will be especially useful once we have multiple group types.
> 
> An alternative is per-type VQs. This is possible but will
> require more per-transport work. Discovery through the vq
> helps keep things contained.
> 
> e.g. lack of support for some command can switch to a legacy mode
> 
> note that commands are expected to be avolved by adding new
> fields to command specific data at the tail, so
> we generally do not need feature bits for compatibility.
> 
> Based-on-patch-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Zhu Lingshan <lingshan.zhu@intel.com>
> 
Reviewed-by: Parav Pandit <parav@nvidia.com>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

