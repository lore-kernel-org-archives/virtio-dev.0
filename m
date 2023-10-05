Return-Path: <virtio-dev-return-13985-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 619E7E936FD
	for <virtio-dev@archiver.kernel.org>; Thu,  5 Oct 2023 05:10:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id BF9DB2A828
	for <virtio-dev@archiver.kernel.org>; Thu,  5 Oct 2023 05:10:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BAC899867F1
	for <virtio-dev@archiver.kernel.org>; Thu,  5 Oct 2023 05:10:37 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id AE6E9983E93; Thu,  5 Oct 2023 05:10:37 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 986CC986521;
	Thu,  5 Oct 2023 05:10:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fcpgHIiKwRy3DJ6W95awFigKKq+Hr5EFclk0J0FE4Y6dm/OXdMxm+Mv5zDUOJujmrNmvMR2gw623Mws2BpvjXI8I7eTtwLOjK4w6AtSm/8wstn2qFsbT42e3JcqtyyITJ5o9zoqeWmayV10hgg10JwA70+QdMjwCcdKZ8s8mgGY9YAgAMYebTi4EwhBtPmzwBJ2md88eH7Cs5iBpdG5JaG31ckDvODJDLYHHnz7DDl+ujp4AX3oGXN0C+SRo9tBRf3DOdgvPZGA8sQ3uj4/8Um9zNpF5xXeP7KM8wJ9/BmjXLlClYStbgLfwiKScb5UoXx+KBTL5qDS3TC6s5Fxh6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Ax6lxSTTJoosv+1PD2fhkNo5Xs1lFjB1LVhAcdga/Q=;
 b=btZonxRoXrnn5XQvWQD40p0ajr5fUNPPpkXFIUoxT6cMy5KgvTvXhhQhADFlx2dM1OaRNA4h10faw9m4iY8vM897KX2jpBTGVt6Bu5wT7dU3YxrrvTj10yB1Fhq1An2AYZaVYM8fRitcFGEO8e6uuttSZvAngqjCCLxTBBBemWAklT/pvFuzX2/4H+9fy8PMmMp8FyZolyZanbGG696pGoVxbPiPAMbO30FEKRQ2Pz/3iF3OfpleCm7EKkQHH1aqMT88ekBKLEBXR0YdvGa8L/s2YC9uXMFOO8ygP8SXxieaN74p/csBcibpggKKX4fb47E41vjPDb9UPWIRn8HzRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Message-ID: <5cf1f33c-73b2-4377-bd5f-242cc18d5762@amd.com>
Date: Thu, 5 Oct 2023 10:40:16 +0530
User-Agent: Mozilla Thunderbird
To: virtio-comment@lists.oasis-open.org
Cc: Mythri.Pandeshwarakrishna@amd.com, Devaraj.Rangasamy@amd.com,
 Rijo-john.Thomas@amd.com, Nimesh.Easow@amd.com,
 virtio-dev@lists.oasis-open.org, jens.wiklander@linaro.org,
 sumit.semwal@linaro.org, alex.bennee@linaro.org, arnd.bergmann@linaro.org,
 op-tee@lists.trustedfirmware.org, Parav Pandit <parav@nvidia.com>,
 Sumit Garg <sumit.garg@linaro.org>
References: <cf8eee37bb9f5c2408f0ed8f4798e87b3c01f39c.1695881523.git.JESHWANTHKUMAR.NK@amd.com>
Content-Language: en-US
From: "NK, JESHWANTHKUMAR" <jeshwanthkumar.nk@amd.com>
In-Reply-To: <cf8eee37bb9f5c2408f0ed8f4798e87b3c01f39c.1695881523.git.JESHWANTHKUMAR.NK@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0212.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::11) To DM6PR12MB4564.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4564:EE_|SA1PR12MB8118:EE_
X-MS-Office365-Filtering-Correlation-Id: 345f7193-bdd3-44fd-5195-08dbc5616430
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LJPfo29OisOprny7YqpPjacCTlBOmtpfPt16EN+MRP5ZaThrjL2tr619xYO4DJsTadZVelGhmYdI7GFCJXL/FTVch0t97DSF+irKSvtMm69PBBD6x6uPr+CEYRe/ZazvSrKib6UFaW3Ycggl41pnhaNNyK2/cC4Roaf7anokHbVPdamev71vs5oT5QuQ0Me+EA+4R33ugz0mDmJfPZ+Pw/kaWDeV5EifiIKrlxiR4grpLOmBack74HETFX6xWeUoI/wlp0Qwedca2mVqHgKxh9exzkp6hSDNprocAO42r3666VSkmuEklMfAdAEPCEHSYAn4ks/LrsCo484zENukY0uTURZpDexI1FnGylYvXnXNVE5SKuEr+5FBPqdLUTQFVd3QDo67WEbgA6ip3NrSaOumMaYzPGQlKbN95FhOrDfbs6OVItrw+3i93FVgEJZyJ84XeQcyb25iSsXf2RIKCWNrleW+lrD/Vom0qOJu66ReDqaywnJEr6u8wemGPrCTOVHWtw5krK3+fNuHJHWu/puEIYz852ohrAzaY/07inP/YBTs6tJ9tVQz36c5SggvvzgfXZ80rkHGxT5TH7nS8qhubhyQR7TYuLEF1OTu/48widzUi3e3HqRYKAk+WyS1I7O6OqayyoHokzk6Lka7sQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4564.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(366004)(346002)(396003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(478600001)(53546011)(6506007)(966005)(6666004)(6486002)(6512007)(2616005)(83380400001)(41300700001)(316002)(6916009)(8676002)(5660300002)(4326008)(66556008)(66476007)(66946007)(8936002)(54906003)(2906002)(36756003)(86362001)(31696002)(38100700002)(26005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nm8wNm9TWWtuSk5JN2NJZ0NTc1o4QkVTaHlWdlByNi9HV1htOGl6NnNIdHJ4?=
 =?utf-8?B?QUNkTnhpMXhLZkd2SFJxYUpKeE50ekZJNnZIVTltT05IalR2dU00RGFuT2tM?=
 =?utf-8?B?c1g2eXNQakpKbUI3QjFEZDJVZ3lEN0t1dloxRWhHSW01QVJZcHpnMDFzWWdK?=
 =?utf-8?B?b0V0Q3JDMjZTNE5QZHRhQXVMbTJOMCtoM3cxYzZucm1ZVHprSHBxU21xWUF4?=
 =?utf-8?B?a2d2Q29ONmYzdml6bDNDcGYzRE1QL0Q0dFBLMWZER3lWaElOY2IxM1BtNW9T?=
 =?utf-8?B?UmdETnVVQXF0ZVNlaW8reE8ySFRvVzZ5RHoxdGdYZVZDMUttL29iSllJMXBS?=
 =?utf-8?B?blY0bVJwZHljVFNDdzMvS0FpSmhMNXRlU0dtV3REbjBaRzlXWHpodkxvRm5Z?=
 =?utf-8?B?OGJGUmVTOVRXTnVMbk16cWcyK2Fjajludy9pdnNCdHpQNnRURit1bXZuUE5E?=
 =?utf-8?B?c0IzRWNTbkFWOFRrTlV1b3hpYi90b2lNTzJoMk5YNE5PVElrcjhmUHEwZE9k?=
 =?utf-8?B?L2cxYXdmWUQ2aVQ4Z0tLWDRaWThGSDlMYlE5cVpYNnExTnlZZzRXUGFDaG5Q?=
 =?utf-8?B?RGZNd3lDSmYrN29Iam1ZVVBzdDVVOC8wVlo1TFNMdmo4VlYzWUFBaHVuV0hE?=
 =?utf-8?B?KytQR2dXY0N4VG0xWHViZGJVczdvalJWS0h2dXVzUzF0OVZUbHNLYU5ZTE1D?=
 =?utf-8?B?cUtWREFsWTVoWjkrNlQ0R3FtZjJERzVaNmxqZ2dZa0FHV3NpMldkazVsMWo5?=
 =?utf-8?B?TzdxUzk5K0hzM0QzcjAvRXJKamFxUFJRVFhTRy9PN0hhVER1M2tUOWsyUU1w?=
 =?utf-8?B?WERyRGRyTDZlRWp4Rk1PQlVhYkdoMHlDbVFPNTA2QTJOVjViZlN2WFdRbC9z?=
 =?utf-8?B?alFleVZ3MHgrL3NrRTI1b0l3VzdzK3FadUZoQnZjdkRXMmF3WHFwTFhNUGw1?=
 =?utf-8?B?VkRnZldSQ2Vyb2pVcVlWRit4U3A0Rjg2aXRFZysrUWEyNHlnaGViQXc0MzdI?=
 =?utf-8?B?Um5vSzk1TTFrOE1iUEM0cDR1ei9kM3ZFV2pyMGV0d2NBY084RW5yV2hKNWZL?=
 =?utf-8?B?Tjdic0lIMnFRQ2pUMWloM28zMnJ5NUg3OVJyNTVQbnhMeGZMd21iTmg4RnZr?=
 =?utf-8?B?UzM3N2ZKOWRFTzR4ZHhyMnVTSTlXOS9BZ0lOVlI5K2E1c3kvRWtEMlB1R0xD?=
 =?utf-8?B?c2ZaRndjZnBtMTdmTEs4S28ydmFaVWhlN0hHVDVCN25pNGloZGd4SDhETkd6?=
 =?utf-8?B?RnNUSHNoUEd5YnAyRHN4TER3SDFpWFJwcFRZQ3ozNSs5QWVlcmVUVnhTMlpC?=
 =?utf-8?B?dGFPWDY5MG8wQ2lyemRSVFRkaFZQR1JQRi9RTUl5L3hMdnI4b3BwbHEyOFhq?=
 =?utf-8?B?ZE5qN1hPVWFtMTdSOHp4QlRyTklYUG9pQ1N2bjVFNFFXc3VQZGw5WGlGOUNB?=
 =?utf-8?B?bktGZ2RCM2FPeVlZNjlNMmplQWJ4dzRmWFJGZjNHOENybVh3S0c2RE5BY2NH?=
 =?utf-8?B?QUVPZlY5bUZXdDY1SUFkQUFFdTNrM1VPT0hZOXVMek0xZVY3U3c4Z1Vpc2NF?=
 =?utf-8?B?WFJhaDJwc09yYkVHWHZpOGUwb1hJSnMvRFQyOGVPbHVTUm5kL1pTcmtlUVZo?=
 =?utf-8?B?aWxQOEFaOXZ5ekNvOUZpRm1PMVJxV3hBNkJ4N2RBTitlMXA2a3JFWVNRczkv?=
 =?utf-8?B?RWQyWURLd1RXSVhscVIvRnprRStIR0trNUVCeVlZR3gzWWx0UHBmcTJVNHFE?=
 =?utf-8?B?M2doSndidkwxZjZkTTFhQkwzdXMyNVQ1UVJ2MTkvc3U2SHRvV1NXeWNFMG1D?=
 =?utf-8?B?VVdDTXlWNUV2c09RWVUrUkhBeU51VTVkb1ZIa2xPVWV3cGRabmxQaStZOTcr?=
 =?utf-8?B?MUY2amgxZW1YN0p6ejIyOGMwY2dTVU1HRS9GdTdwMWZybnRxOEdYYnF0VVov?=
 =?utf-8?B?N1h2SXQzUytRUW43QWVyd1E2QkJVdVdwQWlDOFFNQmp3RFhORXBOTXhET3E0?=
 =?utf-8?B?QjdHbVFCQk5ndHlVaGlwRFhPZmhnMDRJZmhvSjdlYWI1NGZLeFpSNnlCSTJ4?=
 =?utf-8?B?alowaGVPR1Y5QUlrcDNTbDMzUFB1L3pDdTdxR2pZb3pBalJHUzczZm8zZlBo?=
 =?utf-8?Q?6pkx9ujsU1uD1nEHn31xURTSP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 345f7193-bdd3-44fd-5195-08dbc5616430
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4564.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 05:10:29.3148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o4OxxyaUEmsHkcC2ua1RVWkv2vl7zNakIs6rrxIA5lfwfKqWmghXbQ/5LIzYoqK9fFTFz1jFXG2vVx2bL58BLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8118
Subject: [virtio-dev] Re: [PATCH v3] virtio-tee: Reserve device ID 46 for TEE device

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/175

Request for votes.

Regards,

Jeshwanth

On 28-Sep-23 11:42 AM, jeshwank wrote:
> In a virtual environment, an application running in guest VM may want
> to delegate security sensitive tasks to a Trusted Application (TA)
> running within a Trusted Execution Environment (TEE). A TEE is a trusted
> OS running in some secure environment, for example, TrustZone on ARM
> CPUs, or a separate secure co-processor etc.
>
> A virtual TEE device emulates a TEE within a guest VM. Such a virtual
> TEE device supports multiple operations such as:
>
> VIRTIO_TEE_CMD_OPEN_DEVICE – Open a communication channel with virtio
>                               TEE device.
> VIRTIO_TEE_CMD_CLOSE_DEVICE – Close communication channel with virtio
>                                TEE device.
> VIRTIO_TEE_CMD_GET_VERSION – Get version of virtio TEE.
> VIRTIO_TEE_CMD_OPEN_SESSION – Open a session to communicate with
>                                trusted application running in TEE.
> VIRTIO_TEE_CMD_CLOSE_SESSION – Close a session to end communication
>                                 with trusted application running in TEE.
> VIRTIO_TEE_CMD_INVOKE_FUNC – Invoke a command or function in trusted
>                               application running in TEE.
> VIRTIO_TEE_CMD_CANCEL_REQ – Cancel an ongoing command within TEE.
> VIRTIO_TEE_CMD_REGISTER_MEM - Register shared memory with TEE.
> VIRTIO_TEE_CMD_UNREGISTER_MEM - Unregister shared memory from TEE.
>
> We would like to reserve device ID 46 for Virtio-TEE device.
>
> Signed-off-by: Jeshwanth Kumar <jeshwanthkumar.nk@amd.com>
> Reviewed-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Acked-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>   content.tex | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/content.tex b/content.tex
> index 0a62dce..644aa4a 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -739,6 +739,8 @@ \chapter{Device Types}\label{sec:Device Types}
>   \hline
>   45         &   SPI master \\
>   \hline
> +46         &   TEE device \\
> +\hline
>   \end{tabular}
>   
>   Some of the devices above are unspecified by this document,

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

