Return-Path: <virtio-dev-return-13952-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34838E8181B
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Sep 2023 05:10:18 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7037B79572
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Sep 2023 05:10:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 448AD98644F
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Sep 2023 05:10:17 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 27F809863A6; Tue, 26 Sep 2023 05:10:17 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 15F5798639D;
	Tue, 26 Sep 2023 05:10:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gq/bDwC9fe/bs0qfR9lX/PMx5ltu7wfKZhoqjTsnOLeQS5O+hg31gKAkxAYeQrTQ/8zQg70RId2VTQrjgokMPUtUadiPU+M0w91CPJNe6/2T8JhsGOXOFJuvqHaOXpr29qcM6Tzb2Fzs00Wj3GiHDaEqo6Mo806w5N56X2yniNi1QAGeAoDVYEzIc1+zeJKoDPMctfSrLvQQG4xVJa30tomc6UVl6FqGf1OUorm7rvKkUQWm/qDrncdNKJmIBxpKja+uJCEZnMdpmDIbNLqGTvIP0zsEVrNBSOqcDZ/iVv6pdK1UHW+eRwhmnAP6EHXr4yMl4EIwq0Qv3ixkC3lWzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mrf0p5B0mx5RA9a7jH5nQgNyGEFyfy5+l13S6MItVlo=;
 b=S9ApPx3sDR3KWODZXOdaPm7FhhIunQf+i2h9GPIRkZeNTm+WM8pmO9NR9O4gDj8+qO9Vzw/yeKDpC336wHXcrb8pILZzokcVZA+rWP47uzZFvRNsnCBq+ILjC37CKQvMvN6zvsdEy5xIx//R6fm8cIuZUysclYETDexhzaeN0Y9goPanRLsSsSXIx0AqtwCgBOqjCY8a3MA39D6AswALEBuzZQm7aqRJh3uo4mgMU+oMyTa3CuUvmpByo/Vzz74BlbmeNOU5McSV3Auuuf/ebcg4E2B+Lj5ikl7gVcyJ9AaMPlZLcv7cTnnVf/m4tPsarwtaQVN0J7PvvbAJyUpISQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Message-ID: <131d8807-8536-481d-8e25-d15e4396f8b9@amd.com>
Date: Tue, 26 Sep 2023 10:39:47 +0530
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Parav Pandit <parav@nvidia.com>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "mailto:virtio-comment"@lists.oasis-open.org
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
X-ClientProxiedBy: PN2PR01CA0221.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::17) To MW3PR12MB4571.namprd12.prod.outlook.com
 (2603:10b6:303:5c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4571:EE_|DM4PR12MB6134:EE_
X-MS-Office365-Filtering-Correlation-Id: 166bb394-14aa-4ee3-f565-08dbbe4ed9ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xk29Jq+Al11aOJ8+4iKGoo/gqISK/n/bSAfNW3vGpcGU2mQEUvHkhf5/lQi9+ZUsJBP850KhJJAwV78b+CPEpZsCE1bVhwB1tcMg4X4N9DntNeZ7NsIl2XRPCfjCLdOxDzMtlpGsHaPK0SYlCxcOZohnBbYUKFgjM/dimHngiUD/3vs4fEjeWY/u9jYALWQWYUDSRvRldzqptFAyzA+iDmPURin6i02sFAqMQo6AYAik67Nf5+MqaDRTsY4S9jqHR7aLVhLC4n2e4Au1x7KxXTzKW+dhKzaetU1/zdi6hwQRToCDMBE16cQi+RpFevfnj4Sd0UyuEZYmnIay5MO9wxqy36a1q4d2qTNskEP/USx4lAzKxCTbUgBU9rS+3R7kGoFbE8dCddScxiNRQqTkejgCv+FhET/S1lmtJ8q24HjJFhZ625CrQY08JgG9Hg4eNES6nkg4uly63cWtj7J5Fb1CLWA1DBynLYRMkRbauz330+geHYJdbEt07ZkGKWoMCTsT+IbNe/zB6xNsG0RNlGuScHhWEziap0EO79vW6AHMM1VaIdaTwjlRvVYEu87RZuDC7dYTzw9PSWAe93gBERqkFj7iRRC5lyaY6dUNp2Og4q82Xf+/WfYjB1wfflMQ86rb47yxPfGyT42KuGLuRw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4571.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(396003)(346002)(136003)(230922051799003)(451199024)(1800799009)(186009)(110136005)(5660300002)(316002)(54906003)(66556008)(66946007)(2616005)(8936002)(4326008)(8676002)(41300700001)(66476007)(2906002)(26005)(6506007)(6512007)(53546011)(6666004)(31686004)(38100700002)(6486002)(478600001)(86362001)(66899024)(83380400001)(31696002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N1BHL0FjajgrNUo5RGN2UWJuM1Z6b3ltN1FOQjhod2F0eW8vQm52Ri9zQnZ2?=
 =?utf-8?B?MEtIZSsvNmdFZUxPTjVHNlRWWElNWGxaOUdDZXh2ZkkyWHp6M2o0aDhXQjY3?=
 =?utf-8?B?aWdCVHVIRFpTT3NLMm5lbGtaSTZWRXN3YlR5MzMrNTZjaVNtVXZnNFpVRXdF?=
 =?utf-8?B?d0xacFN0eThBY09VejFhak5XUGZ1enlwYWZJMlhLenJENkhTQ1RVSUZCNGZp?=
 =?utf-8?B?b1ZLTDFiek1aMHJwUDBEbXVNZnBsUHJPRm1aczhQd05Jckx4QUVCTG1ySE9s?=
 =?utf-8?B?ZitPR0ZjT2dRSXZabFRQSWliellEcnZlbEVCa2o0RXdNL1c4SEJLM3Z5ZVZU?=
 =?utf-8?B?NWs3WUpzdW5wZlNyRDFGOUZxenhLVnQvTjZyWEsvTW9SeFVHcXJCekNVTjNy?=
 =?utf-8?B?OHV3MkdtNFhUSFJRQ1FvdTE3QU5pUjB5YnB2Ui9lSitoamFySXlnRitrWlh1?=
 =?utf-8?B?bjkraGcxN3l4WmdxS3dsbmFVRUFRS1dOcDNQN013SGRudThlRFh5Ym12Qk1X?=
 =?utf-8?B?ZGxYNzlwUWNvb2RZeWtnTUpPeGc4N283ay9rbTdncjg3YjgvdHJJWWFkbzNV?=
 =?utf-8?B?c1FrN0NNU0JyOFdQVlF3cVVaUDI0NENmVGdaMWdXUTFlZ21PSTV2WUFIb3ZM?=
 =?utf-8?B?eWJFZjdCK1RzVEc2a0VZS21CSkFFSFdHZ1lPdUhIOHQ1OVJ5QlFKLys0SGtM?=
 =?utf-8?B?MVQ4Q1N1cE1qMXJPbzY1TC9uWlJtaE5tcGlMaWdMdFhBMDRwc0dPMzJYb1BD?=
 =?utf-8?B?TkNKN2ZHY25sVzFkcVE2REhoK3MxaFVpY1c1anpRdEU0L2lxbVU3bkp5bms2?=
 =?utf-8?B?RUlNTThpZEJ2RUtuNVp5UGV4SFVpVk9rZVdaTjYzL3FJSEVNTXNuSnIycVVl?=
 =?utf-8?B?akt5NFhHRVhLbjhERFkyRnBzajZGYUkzL0VPY3hRcnJiV3lPQ0k1bithRDFJ?=
 =?utf-8?B?OWc0Y3lYWnQwbU5VdWVZTHNmdFJxcndnbUoza1NXZG9HaVRSaHZoU3hqZ1c1?=
 =?utf-8?B?MU5hNmV6M1UxNmZiUjZWVFBUUTJIOWhJRENKMW1pVGFzOS9tNlY5eUJjWE9m?=
 =?utf-8?B?R24rcUJYcFc3akZwZmVRSHJNQnlXUUVxbjRJVHRiRExnVDNhd3Q0c1ltb3N3?=
 =?utf-8?B?L1BKbDNYOUlmY1JhMHFuWmxEQnoyeWUxS1VkeCswQ1dkM0pLcDhvL3RiVUZK?=
 =?utf-8?B?UElLR1ZhRmNJQzZmaHJybFltTjJoRmVUS1JPbGFvR3o4WGVYNHAyOXdlM1V3?=
 =?utf-8?B?cUk4dC85VXF6dFZ0WHBrZXJBOHFReUNjM0FqKzlMeC9xTzkybUYwUGxweUxN?=
 =?utf-8?B?dXRmOENkNHM4TmVDcEcrRjhYaFZpRnVDbVI2enFyUXJQbjBOcEM4Qzl4WTlM?=
 =?utf-8?B?U0J1QklPSzZROVlZMW9Sb0pEdXFXc1dzU3hzdGtaclVmV29DNG1QcklLK3dw?=
 =?utf-8?B?OXV4N2o1eVRUQW1tUWY0dDJDRENlaE14S1pmN3VHZ2tza0dxVFA4V2RPbVBE?=
 =?utf-8?B?OGhmZlI4VWxXVVBaczFBUFlzeUR3MVpNZStUeThJZnhSM3RqMUlLa3BWSG1x?=
 =?utf-8?B?emY3N3BsNmo1aWEydUVPb1RRMmVJVkxMekNodFNrRHpMOENiYXBJV2tFdUgx?=
 =?utf-8?B?L0JLNEQ3NVZqdUFWeFBBaHRzQ0dpdVNwWTZhYXl3ZUhVMFMzSzV3UGdlMTEy?=
 =?utf-8?B?RDZDclJmQll0dzJFOW81MnZ0WlRPZWRLOHNJbUwvclFTRC9BNTNna3hxK0ls?=
 =?utf-8?B?cEZQVzFyWlhGdzZaYU5LS3FkbFdKUjdZY1YvOVVIa3B2a1FQRjVKVGhhNnNL?=
 =?utf-8?B?MlZCaTBhY0d2ejdOWjB6dndBdkJLaGRrbWhSaTNYUmZMRitmWElwWVlyeXZp?=
 =?utf-8?B?eXE2VS9acmZqaWRYbnU1Q3dBMDVGcmdOOHpYZDRQWUt0NFB5ZkIySm95Vkpq?=
 =?utf-8?B?UHA4bDBqVGNDRER6Vkp0c1R5N2FiOUVQNnA5UGRvT0llYnpKWFhhK2U2SjR1?=
 =?utf-8?B?NTdXQjh1REJYZWR1OGF2VU1kU0JtelpUaHN3OTRzWGpFY1hIaXNEenVFemRI?=
 =?utf-8?B?NmVMQ1BObFlibmdkWHlaQ2p3UFV6Zjh5YWpHaGE3MmZ5SmVrWXRiMlhLbjBn?=
 =?utf-8?Q?8L5iOGld4RnjYMENoiAttYCDQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 166bb394-14aa-4ee3-f565-08dbbe4ed9ad
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4571.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 05:10:07.8289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gd4u6dXgK6DBidBK1wrtF/btemk7uuocQWu9Jxtw/lI0zPjbgZfpokX+x/jZ1LJHSiTRCtYXXHbT4rFoobXr3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6134
Subject: Re: [virtio-dev] [PATCH v2] virtio-tee: Reserve device ID 46 for TEE
 device

++virtio-comment@lists.oasis-open.org


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

