Return-Path: <virtio-dev-return-13953-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF06BE8181D
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Sep 2023 05:12:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 38F142AC47
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Sep 2023 05:12:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 34985986496
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Sep 2023 05:12:38 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 289029863A6; Tue, 26 Sep 2023 05:12:38 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 176E098639D;
	Tue, 26 Sep 2023 05:12:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a6gpv5Ks7xCTt+/x2VYo+OURFTRxDp5KaReTEzTDwHfLwnhGz/6/BugHN4YZ8GrsP9BAsr77OyljRmNq5aP824ByN/+AMGrK7wmkAqeUa2LfB/17avDLws4+dMnvzyXEpuoUHY6Ze5IY/dKZyxZm+dvZHm+/9aShmwU6NsU5OxEjrw+w9SUwueDxu6KIbGXHvwU+d+33QCU9OLhpn7BU8Xk4ZBGfXdcgNedLxBdvsLlb9+43A1Qg+xFkBFvmIXIYDliyE7Y+zhvK1jJk+dZmL1F6kEEzcAZBUpZQueSx9GU/8R4TrbrzR97Orpc1jrB+FU6FBwecI7KYl0aIUx2btg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85bvMqKZw+963bL9qdggjv7kPEELj8atl3uT/HwRKbI=;
 b=eapvw8lEb0GQuk9BNkp0DjwtZ9Xud2SZ2vqfBnjwcXSSrksNtNB6HWWr0akrrgksKwLTAYX4OlXP5Z8rG80GvosWxWa+HlbVsSmviKh9NUhp2SHukWhg5zFXyKVHP9u6LypA7PcY/ptjt15Xq3hB6Zbc4ymXG3gAF07o0TRsIF8AyJyyZXXOKJHTiqrRqMLtOL1Uh9ixs75aLGrQDjSPJNrd3kKWay0Ru/EOgBkjOFfii5t2x9E9fdTIg51PIIR3lRMnzrmoM7JzS0URLPblhrsS1GN46TTAy2Jp+MHPzsqIQz2NeIR8IwRMx9Nx/yngoPm1qrA1MMTGzbWoZYjxjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Message-ID: <202c1c9c-661a-43b6-9017-279d68fe2205@amd.com>
Date: Tue, 26 Sep 2023 10:42:18 +0530
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
X-ClientProxiedBy: PN2PR01CA0035.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::10) To MW3PR12MB4571.namprd12.prod.outlook.com
 (2603:10b6:303:5c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4571:EE_|DM4PR12MB6134:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fdbbb51-e876-4ddd-d5b7-08dbbe4f2f66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1BOX/cQHbO+hRxC5cmfJzIZnO4PKImeZGteYRFFWUQI1zWFoPnFtnk8gw59Nxe7WN1UjNt6sFXNmS0ef2ddDReKwFXWIsvwGVmbzTrXVoAf2Cqz86eWR8Gf+jmyQiPg9ixrH/GzVP/a6a4OzAknbOHzcBB4dI5kvTj045P8gqF7c3oE/eed0rsOxawmJklmYXfTGxuo862S3eQOItKzHcZn2U7wAq3hRJI4OOmRPCU+WMie1VcGzSSpMDLQUvM5vNVdnUy/tsw8T/ndKzyV50NXlulNm377Jxc0LP1L3cxXpq2zgr7OCFNdrtZyc+9Wz3lzbLsg3CJVIs0Vjon48+NaASoDP2jbniCMZbKz12+kDMD1CYE7AB+vTV0PUTpmCr6jLkWo9yiRI33uAKRfY0v09q4hEf1b2EZKT9ZisFYgOkyh7ECqjcAEjzx08XCJPeq3pR/bDN6L5yeoA2C+NPEmeeegqBZn7U2iFUGi9GcH6IsQK+KRxZmyu29QCSqFOrhbu6CmqQ0JXhQ5s117JzPiV8svj+NbzJnKbeSvYIfKVIQdDX1Ep+MB+ryBJi/+ZUhi7e6K5pCmZDkbKuDTAU8wMhatvNR6WDYqlwxiPDvymE9nh9e0ma1OE+wGRzRFftF335Ow6VtrQ0rkxH1KeRA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4571.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(396003)(346002)(136003)(230922051799003)(451199024)(1800799009)(186009)(110136005)(5660300002)(316002)(54906003)(66556008)(66946007)(2616005)(8936002)(4326008)(8676002)(41300700001)(66476007)(2906002)(26005)(6506007)(6512007)(53546011)(6666004)(31686004)(38100700002)(6486002)(478600001)(86362001)(66899024)(83380400001)(31696002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3kzN2tvNmZmeDJKUkNSRGxaUVY2N0lzcUxBUitRVFN2MDNaZS9CL1VZOW1Z?=
 =?utf-8?B?UExodUw5WWpGSVE4MUF4S2YrMXMwVmkwOVd2OEpFSVRVVDJuZXYrRCtLWHZD?=
 =?utf-8?B?T2hHak82NHFXRjA2Mm45YmI4UWdWVUZCd3h2SlI2eWRET3BIMFh3ZlY0S1E2?=
 =?utf-8?B?bXJUSEZkUGFFZktDM1BPWW8vNmhLUXBmYzVKOWRvRTRLZWFSeXZsQUVhWk5w?=
 =?utf-8?B?MDZ4V1RqWHZjQ3EzaHFLWi8vd1A3ZWhyaG9RVElISlNDZ3k2bDYyM1h6YVc4?=
 =?utf-8?B?WmtIcHFYRjJVeS9TSWxVa2dLYy96NnlaQlc3eXFjR2s0YnpXMnJEdmF4ZmNo?=
 =?utf-8?B?M3JlbW1rSVhYbWdRQlh3NkN5WU81dVVmY1hYbHpGaVJFS3NzOXFUblk1cGZi?=
 =?utf-8?B?ZmtDcVlySlB3bktSR091TzJoWWpaNjJnSWNEeFJuOGJPZ2gwRWVYaVNuWnJr?=
 =?utf-8?B?b3c1Z3prRXBlQ1VGcnFrMkxldEtqaHpIaitGSERjMCswSDhsNGVQSUxscEov?=
 =?utf-8?B?Tm5VdnJBS2ZFc0dKVUtQUlU0WUtrcVg2bzhadi9SRE9IUFNaTHlRaTJ1eEda?=
 =?utf-8?B?MDlSMFp6OUV1amFvS0kwQ09LRHMvaWhadVIrMS9rempySlEva0JDalQrUG91?=
 =?utf-8?B?S04rWHNDbjlFQm1CZE9MRStWUGkxaW1ycmNWd2M4MWNHRTYvSHd5WmJyWFZD?=
 =?utf-8?B?aEVhVTlLa29ZYVZDeHdKR0M4YVFWcVFTZjdINnY5MFRnVVJkVWtrNm9JRWMx?=
 =?utf-8?B?QXhaNTFNTjE5K1FYREFSUzRGZUxaL2JrZVExcGd1RHB2blZUMTVwbUk5Tyty?=
 =?utf-8?B?WmdrRGp1Wm5kSjVUbXU2NmxtYmR4OG1IR3NSYTYvalBHaUphUVkvMmJ2dkVB?=
 =?utf-8?B?a0daSXU0VGgrNlE1QUR5R1pFeVlNdXZSWGExenM4RDUrNEwzRWVpNUdSQThO?=
 =?utf-8?B?alNrNVhFQnhNOXFlZ09lZHZrOGFDSnJCckpVWURQRy9WMlpXc20vTUhrMDB4?=
 =?utf-8?B?Sy84T2lXQzFySVJlcjhlM1RFLzB3NGRKbDRRV0VJK3pGWDNRa2xTZU4zK25Q?=
 =?utf-8?B?V1pJRXNiOUZUMUNGcnFiREdQbThDUmRLb3RNWFMwU2NnMVJpakhWNG9BRGhK?=
 =?utf-8?B?ZzRZV0NUOEpOVm8yRi9MTWVjMU1MTys5T2xSWmh1SGN4RjZaUUswS2JYTkpU?=
 =?utf-8?B?WVEvNWk0OENIcHRLL3g5Z01JVTROSjBHd3h2TjVqS3p1UVNkYStnZUlhNUw3?=
 =?utf-8?B?V290T2JsZFFUTEtvbkk0MVd0Q1R6am5Dd09LQjhTdjBFc0dlR3NWeE9Wc2JR?=
 =?utf-8?B?TWdZd0N1UTRFYUlCQTBmUTJTWWkvZ3BodjVZNlNzR25TeHNub1R2TmU3Nlhv?=
 =?utf-8?B?Vm44MmZYYVRQQUswcTU3Sm1DOXNVVXBPUG81UEp2d2syT3BWTkxNZ1N6QlNw?=
 =?utf-8?B?Nm5tbk9vSUk5Q2MzSzR2cEJPNnkzM2VNMnJjZ096cGE1SnVQVWUxc0QzWjhq?=
 =?utf-8?B?bU42UHdMSDhlU2gyZms2TVBTeCtRczhoY1MvUzF4U0xvTTVON0g2NDZTbVVC?=
 =?utf-8?B?KzNzOGdpWE5BOFBOUUxwaFE5YlZkTm9LQ1BmY1Fjam85eGtzbGNseXVxOVVV?=
 =?utf-8?B?dVRZZjBiSUtzaktvRWU0WGZxeUc4K2svNlVNdUY0MG8zSlhjQzh1VUQyMlRy?=
 =?utf-8?B?dkdVeHhkQzhhQmx2WkZRaDRlMW9vTTQ4aTMvUXBaVUZxUTNvdGltYjR4bS8z?=
 =?utf-8?B?YVZSazFqNU4xaDFNWjBoK3pvNUNPRlNrTE9nd1Y4ZldMc0FDcEdWZWpEcVhM?=
 =?utf-8?B?SW9DZEdtQlZaWlJDVHBnd2dkOVN0alhpaUZpeVhkR1hJRXBrQlpvclRqejRS?=
 =?utf-8?B?ZHR1bjlTYU9iM0tGclM4MklvWEVvaEVMNXY3UlNxU1RzakR2cUtjODhVL2Ja?=
 =?utf-8?B?TDlFQlFlZDIyYTFHOEgvNlRZSDNLUEVtdXBXNlE0Nk1BMWRlbzRSaFRpYlkz?=
 =?utf-8?B?blRzcWdZb0hlbXJuOTZOVWgycHE4bThpUFhMcG5wVTd1dGZ4dW1rZ1Z1aity?=
 =?utf-8?B?VkRIeml0MVdHeVhBMk1vQTlMYnptNi9NMzczODhoRlFWSVVYSmQ0NldvQjl0?=
 =?utf-8?Q?AD9i0+IIA2HfSFQzf2M5KdkMv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fdbbb51-e876-4ddd-d5b7-08dbbe4f2f66
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4571.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 05:12:31.0814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Bx7jxJYn7ZPieSbNY/fezoKjNUa+EXKfd+EB3OnG0W4mOSGKQaU0hfMPYtKXgQe67Lubu+yCjkB9EA4MPVTbQ==
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

