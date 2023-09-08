Return-Path: <virtio-dev-return-13653-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 510D4EE57CA
	for <virtio-dev@archiver.kernel.org>; Fri,  8 Sep 2023 06:24:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B0E1161260
	for <virtio-dev@archiver.kernel.org>; Fri,  8 Sep 2023 06:24:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AB18098660F
	for <virtio-dev@archiver.kernel.org>; Fri,  8 Sep 2023 06:24:22 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9E47598413A; Fri,  8 Sep 2023 06:24:22 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8923198643A;
	Fri,  8 Sep 2023 06:24:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JriWM0XJR6g58exeU/Dmyy7FPH0IpB1rFglY+FYRC4oEYkfVqi+nGLD5Ea+AnjycHXILSJUMg8X/NP+1iKjajGIx7Twyxj9+pMwBQIKEQllUV8Z9Y7UJE8Vce5bJ/Zi/Abk/ptg3wrQdrj/zdPApp58HD3pSi2rDOGVe1YURdgy4jigi3Szy/h6z1T/KAIRQ3iay24thPsy3f0Xfa9Vge4zwIeqNs3I2VjwrExXouprMGQSNfpU7uQBS//0tip3ho5TPRq2hr7xdgrkKd4QVyC+hEOwoGOvAQld85KizcAOX/qQONjZtnkDOkse4+8DGzT/qCVbVsvsomUlb1ihL2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JWDxICTNxdBNagIWhAVe+Kujt62/2JLMtB7JsbuS6GA=;
 b=ZhK6qMYd6vYE4bPlVcAFglYQXJLp0wMkYR4PqGsB7dmxjSv3ZKwpk4vaYf0P/GMk77n6DeFIEqjIZuNSpJXDdGWJePS5t7EMI4J4X2rRrTguYZS7khivOeHwh2Vav56IXsZdSb7I/AeuRT2OW1yscu/OryHzzUsuzgcOq8lmypIrLGtTxSicMUO3WsPXuGGSyxRwwfbTuonq0vY/96V+bBcax5kkK9jJqnspOuDJ2zTRVc4xe7lysqttUa1IOTwBBD8dYFi1BBuAAha1q8q9Jv9k2SnN9UCNsu3ElV6MpzaQzdEqZKYaGiTliZWA2MDGg1uBPQT9Bx2BobNap+1lrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
Message-ID: <cba0b7f2-e40d-80b6-adb8-a2b4a4eb1bd8@oracle.com>
Date: Thu, 7 Sep 2023 23:23:27 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>,
        Eugenio Perez Martin <eperezma@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, mst@redhat.com, cohuck@redhat.com,
        virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
        Dragos Tatulea <dtatulea@nvidia.com>
References: <20230814192904.30062-1-lingshan.zhu@intel.com>
 <20230814192904.30062-5-lingshan.zhu@intel.com>
 <CACGkMEtkdXrTZ_=NkuPsmhUooCgKPiCiVo-nJMaDnJ5fufzGwQ@mail.gmail.com>
 <8ce92e00-39f9-3e99-96e2-5599588869e3@intel.com>
 <CAJaqyWd=hCvknO5MQ0Nu4iwxPMfjHGHNJHiwzxAaRLcgZ1HKxg@mail.gmail.com>
 <23b9082d-050a-6f82-754e-d309c48972d5@intel.com>
 <CAJaqyWeye4fOTB5pPtwpzusgZRL6d36EzDD61zoD8Uf+0v4FQw@mail.gmail.com>
 <4f88bf69-7436-4f26-6be8-76347355d59c@intel.com>
 <CAJaqyWeLeyBJSn2EH9-vfbyVCAcCKDuhp-1G+3QZGpVMf7KTDw@mail.gmail.com>
 <20ccafc0-f896-07df-f688-6f5d250a0b05@intel.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20ccafc0-f896-07df-f688-6f5d250a0b05@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR13CA0045.namprd13.prod.outlook.com
 (2603:10b6:5:134::22) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|PH7PR10MB6228:EE_
X-MS-Office365-Filtering-Correlation-Id: e2a9cad2-ddcf-421c-aec6-08dbb0341edb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	y9tg0mwp/ZmWo5OQd67y7CQnfgHKP4YckM1Vh394QwSqQ2Ic/3k8JZBCPhWw0sQThSww0O2Wcr4ONiF29A6Wn/BRHylQwwGX8NECLUTtKQBNT2beBsoEibJSLKN13weU1pb1IRX5kIM2bmoDPEjZY1ipN/WuxLV3tRHuK3COTtBI3GZMTRzvTFW5a7fFuFw9/N4DvGHl3pjxMKzhSPLr6FusjOcUAAIine0GRSNXu2m5MHFfOZcYKoePmLjYpylqmqgXRajmo63Jedm9gmBV5/UFyWLW9Cm6dDY+HnUEvbrm2t3ePEdTWeBWSG0zfSYzyAVtkOOH4cCe6CsjhUZBdbKLm11Ome4SrdefJrjDjzqriFczFsxDMgP9DGBhftycMIb9RR0xYXsrbEgTtrrF7slQ7dPwu86aTmp7TxsxxxXVoqiqXP5t0owmljXjW2Qp6G5vByIZLgTRSPtsOIzvvX6hvQmJ2BOjaSF9/ScwCkkC8P8RP/1ZaisfnjRMneozJVL9gfO8bD+jm6WGcosIZwmSPh5OhgkHTm628GYNzGEvPPq5oKkAD7deIsvOLCJZoAPyMj0UQV4MbDYoqMPyzERJDlc5EyepzcrD98f0hiFUiTHu1jBsJx/CKs5z1uLP1601N6V5IFPM+uU9FdnQ70LC5vo294DE1KuJIS7hJNCNkFUTerLpSBY1PKQG5hDh
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(136003)(346002)(396003)(1800799009)(186009)(451199024)(53546011)(6506007)(41300700001)(6486002)(66899024)(36916002)(30864003)(966005)(36756003)(2906002)(478600001)(86362001)(31696002)(110136005)(316002)(66946007)(66476007)(66556008)(54906003)(38100700002)(6666004)(5660300002)(2616005)(83380400001)(8936002)(8676002)(4326008)(26005)(31686004)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UHVZZlc3VXJ3SVM4S2trS3lTZmdlVnJrMFB0K2FCY0ZONVJrUUlhTmdSU0wx?=
 =?utf-8?B?VlJEdVo2RjNKc2pmZlFGWHl6RGI2TEFxUkVWdmNIQU1ZSk5ZcXJVbkxtWlJL?=
 =?utf-8?B?TzVtb0oxWDF6QzhPOGQxYldjS3pLaC9oUThsc1pKUk9GbHB2ZWhnN1ZqVTZq?=
 =?utf-8?B?R3p0dkZmVlA1Q0xHT0hOTUNBVGJzWDRDUzVSYXRjK1NzUStlQ2JnTURQZ0xa?=
 =?utf-8?B?ZUxwWGpVVHJWKzBGK1p4SjJJcEFOVDhyb2NvK0V0VUtrbmt5b0ZrdkxjL0Rm?=
 =?utf-8?B?eHY2VkRXaFMxTTAzK0NqbzgwN0ErSlRHLzkwU3ZXZDhBS2Y0S3ZtYnM0UFg1?=
 =?utf-8?B?a2g0WFYwM1ZBSVMyc0FzV2RTejhyU3pna1YzVUkyRk4rb1ZyczZLSksvRHpI?=
 =?utf-8?B?L1c4ZEJJR1Q2N3c4VDEwVEcvR2dlUVJ0TDlkMTFGcS84dDVZK1d6NmlnaGsv?=
 =?utf-8?B?QVNXcnRUa2RsdU1UMFUyTGk2RHZMK2g4RTg5UnRXWWliWVVtdHpobFJRdHpz?=
 =?utf-8?B?Vk5ubG5uQ0F6U3c0RXY5a3gvOWpXbmxrWWVFLzhmMi84SXNENE5FNU8zRjI5?=
 =?utf-8?B?ZjhYajVVZzEvVnBYT1FEUXpaOVFTWk5KenpTVVAxTWl1Z0kvMytHaFJUZ1pB?=
 =?utf-8?B?bFF0Z2RyWXVRTkJiUnQwTzNRMjRJOXpyMldqeDJhRHErd0VscUtuWlFRc0Mw?=
 =?utf-8?B?eVFOZS9FN293SUtHc2pZaEFNYVJVREhab1hnVTFNNWk0L1FuQWV5YjVXdk9C?=
 =?utf-8?B?UmRKZlRvUUpGR1JkdTR1QkdTcXhLQUJLdjFqdzZlUGhWMlBFZ1BScUM1ME11?=
 =?utf-8?B?ZXRVeGxyWkdwQmRKenkzcHN1YjVTS3FIOFJ2bXgzREp2dUhVaExPQjRUcGRl?=
 =?utf-8?B?ZSttTXoya0xheGdrcS9JZFFPMStrWnRUb1BzZC9qU0VsLzlaRG81ek1kb1pY?=
 =?utf-8?B?b2hBVnhCUld5SmtPRmZKS0Y5NmhBTld4UkFHRmQ3cC9IbHIyQzlSMkNGZDVN?=
 =?utf-8?B?TzZwL3BCK3dESjV4NU9pemxZL0xwZjJWVlZsanZTejNiSlp5UFIwWHp4Q1Rw?=
 =?utf-8?B?R2h0QWlkbFh1TXZldjBoWkpoQlY1YXE5OGZUcXJtVzNucE9HZFdrTHhVWkxx?=
 =?utf-8?B?aU9MZWlSckdYWVF1N3lnYWMyYzhFdld5Z0p4UURKZ0RFNnFuNmNWcGJ4Qjdz?=
 =?utf-8?B?R2V2dUs0R3A0MUwyM1hRS3d0RnJ5dTlOUk56Nk1RazdiTmU4cWxJaXNjcXRy?=
 =?utf-8?B?STArWVVmOU94cnloaHhsSEw3Q3EyWXVONytkcDRiT0tCZ01hZFF0ZG5mMWRY?=
 =?utf-8?B?aHNONGZxVm5YMldFZXhGZ3BJRDREYlpjbXlGbmF1ZVkwUitaNGNMZkVzTTZQ?=
 =?utf-8?B?N3FEM0xJOWZlRkF5NmRHZHpCR2FVdVV2WENnWE9HcWdCK2NmZUZROFF4YzJI?=
 =?utf-8?B?MVlseCtKcUtvY3crajhsZWZJNEpUWmY4MXJaTFBiejVTR1RZQVBaOUFwYkU5?=
 =?utf-8?B?L1NCSElueG5rMDRnN1NEdGgxaVA1SDRMenVCUXM1LzlYU1p5RVZ0VTZlWDJL?=
 =?utf-8?B?aHAxc1A5Z2hxN2hZZkNBRTNkMktmVFFESVJVV05JREc0V3lNZTRiT3AzL1I1?=
 =?utf-8?B?bCs4eHZEcmkxd0xQUkZNUnhHK2czaFZWbURBRTFyeTIyc0VLdW1MdzhVTStr?=
 =?utf-8?B?Ums2MEJLYWdBd002ODVFNFhWcnJSSVE3bE45NitTbXV2TmVEWHhJUEZ4ZjhC?=
 =?utf-8?B?Y0tGLzlnL3g0WHJqSEhZZVFWMWxCK0M1ZmdKbFpTcXBDd21lY0ZkcE1SZWlK?=
 =?utf-8?B?QVRnSUlqVW5YN2JqV1ZhV0dLTzQwakNmT1hod0lFQlAyRmk5a1BPKzZKamRM?=
 =?utf-8?B?c1pVYzRaWkgwUDBHR2pIOXpYSFhpMVNFYlh1Z0FqS0UxbjJZd1lKTmhXTzdB?=
 =?utf-8?B?YTNjV09qcWhuMjI2bXhVMUVta0ZMU2VnWlFqQnJVNGFEREM5eHpjbHNwdTNa?=
 =?utf-8?B?Y2dLRjF4Q09BM1RtNVphNUJSMVZITFhFUEZQSE83MGNMY2pxcitJZnBYc01M?=
 =?utf-8?B?aytuNU4yWHYwWWxNMHFPNXVSY0VZTVh4Q3llVS8vZkp1NDRsS29DMThnSnhB?=
 =?utf-8?Q?STUSeiGIhAqZvsGbpOMGYKajV?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	p40eBOTksgLkByQqzGdDRHx2xXlvDSPqY8MPFs2JtPgkqdmIDKvyrjKCZal0zu8v1FL73vRsiOVTsVLAzvjXuhESmpd6Gk3HFOhssgd8Iz67IZYH6cyOioYBT3/GiJaXao+pR5JJdvd6wKwA7wU66BzWVJTWhbv0JV8SZpxUwdJmeykD6NOwOXNb+xjkzFhyCAN4xBDdJdFT598teb6LdBnIyaW0VranxxWZuudWZ8YYbAaI0l5eNFdc13UiYYPtryy/UVMXX8fa04oiu64XZzS4xocEMAuan8JnjuleFe/9G5eExHBTxS+zj7MtRMHwStFTjkK+sd1FJJxfBa0JQ8nW4sxUsghPsO8c+pI0nKmdLOuySqq4W0vtg+1Mv1QNqIHjT4lNvT0MA3fmT6Ljp5O1JEHsXVkZf1un/5eSE2awl4USp60UaTudIFPqMotzmre8itSAZw2W9QKkO1bX1LlU/8BaTKw48RUenzeurcxX9rNp6C3sBBBgI0ULHx666aPGQULVfIxTyKyxxrUact3Fv227pbjDfWvFa2ZUGfYj5AJWNwX9vByf0P25MgHHw4ItyJExXFoiMXxGFgbO4MskeXl37JNRtEaIPEe7/xjYdKrgyG6eLZHRub2UPslhjIxAv3QzGlbJoURX82RBtUqWXwAZDClCUQBD/LoMDUD0y4lYZd1o2K/5t0uFe79SRGs5qpSu1nazhsRK1IfpJhgaXD41pUyxfzQJbFeJbQeJ/WeuxlHuabqAm/kkM/yuOeucKJrCptt5nLvremIybY0zox9h09sRuryvCO4TgUKlJ/SAwtTQQ+LmTUkZw/oBBL3+arKW+1eqZkHHAcl2mw9DPnDBkQwo2FbVc9uL8+M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2a9cad2-ddcf-421c-aec6-08dbb0341edb
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 06:23:30.6794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1hHUL2AwbrqCDDgJkH3707dToeViSJ0fRknbj9gAwRip/d67fOcdkC2zy/vPennjHtk/2mYrSYXtWc7hhwsQ4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6228
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_03,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309080057
X-Proofpoint-ORIG-GUID: GpJFZ6S7JJD8MGodgGGiaCG0fpIMM8sv
X-Proofpoint-GUID: GpJFZ6S7JJD8MGodgGGiaCG0fpIMM8sv
Subject: [virtio-dev] Re: [virtio-comment] Re: [RFC PATCH 4/5] virtqueue: constraints for
 virtqueue state



On 9/7/2023 2:34 AM, Zhu, Lingshan wrote:
>
>
> On 9/7/2023 4:09 PM, Eugenio Perez Martin wrote:
>> On Tue, Sep 5, 2023 at 11:08 AM Zhu, Lingshan 
>> <lingshan.zhu@intel.com> wrote:
>>>
>>>
>>> On 8/21/2023 5:26 PM, Eugenio Perez Martin wrote:
>>>> On Fri, Aug 18, 2023 at 11:44 AM Zhu, Lingshan 
>>>> <lingshan.zhu@intel.com> wrote:
>>>>>
>>>>> On 8/17/2023 11:19 PM, Eugenio Perez Martin wrote:
>>>>>> On Tue, Aug 15, 2023 at 1:30 PM Zhu, Lingshan 
>>>>>> <lingshan.zhu@intel.com> wrote:
>>>>>>> On 8/15/2023 8:34 AM, Jason Wang wrote:
>>>>>>>> On Mon, Aug 14, 2023 at 7:29 PM Zhu Lingshan 
>>>>>>>> <lingshan.zhu@intel.com> wrote:
>>>>>>>>> This commit specifies the constraints of the virtqueue state,
>>>>>>>>> and the actions should be taken by the device when SUSPEND
>>>>>>>>> and DRIVER_OK is set
>>>>>>>>>
>>>>>>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>>>>>>>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>>>>>>>>> ---
>>>>>>>>>      content.tex | 31 +++++++++++++++++++++++++++++++
>>>>>>>>>      1 file changed, 31 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/content.tex b/content.tex
>>>>>>>>> index 43bd5de..f6ac581 100644
>>>>>>>>> --- a/content.tex
>>>>>>>>> +++ b/content.tex
>>>>>>>>> @@ -587,6 +587,37 @@ \subsection{\field{Used State} Field}
>>>>>>>>>
>>>>>>>>>      See also \ref{sec:Packed Virtqueues / Driver and Device 
>>>>>>>>> Ring Wrap Counters}.
>>>>>>>>>
>>>>>>>>> +\drivernormative{\subsection}{Virtqueue State}{Basic 
>>>>>>>>> Facilities of a Virtio Device / Virtqueue State}
>>>>>>>>> +
>>>>>>>>> +If VIRTIO_F_QUEUE_STATE has been negotiated, the driver MUST 
>>>>>>>>> set SUSPEND in \field{device status}
>>>>>>>>> +first before getting or setting Virtqueue State of any 
>>>>>>>>> virtqueues.
>>>>>>>> I don't get why this is a must. It could be useful for debugging.
>>>>>>> To avoid race conditions with the device and make the device
>>>>>>> implementation easier
>>>>>>>>> +
>>>>>>>>> +If VIRTIO_F_QUEUE_STATE has been negotiaged but 
>>>>>>>>> VIRTIO_RING_F_PACKED not been negotiated,
>>>>>>>> typo
>>>>>>> yes
>>>>>>>>> +the driver MUST NOT access \field{Used State} of any 
>>>>>>>>> virtqueues, it should use the
>>>>>>>>> +used index in the used ring.
>>>>>>>>> +
>>>>>>>>> +\devicenormative{\subsection}{Virtqueue State}{Basic 
>>>>>>>>> Facilities of a Virtio Device / Virtqueue State}
>>>>>>>>> +
>>>>>>>>> +If VIRTIO_F_QUEUE_STATE has been negotiated but SUSPEND is 
>>>>>>>>> not set in \field{device status},
>>>>>>>>> +the device MUST ignore any accesses against Virtqueue State 
>>>>>>>>> of any virtqueues.
>>>>>>>> Btw, do we need to clarify the behavior of ring reset after 
>>>>>>>> suspending?
>>>>>>> I think once suspended, the device should ignore resetting a queue
>>>>>> Actually shadow virtqueue could benefit from the ability to 
>>>>>> change vq
>>>>>> properties (addresses) while the device is suspended, and then just
>>>>>> resume it. I've been told that ring reset is overkill for that.
>>>>> If ring reset is overkill, is SUSPEND even more overkill?
>>>> It depends on the cost of recreating the vq in the device I think. But
>>>> it has more to do with *what* is changed in the vq, as it seems some
>>>> parameters (vq size) has more impact than others like vq address. The
>>>> way to stop the device does not affect, but ring reset offers the
>>>> possibility of change all of the parameters already.
>>>>
>>>> Adding Si-Wei and Dragos here, as they pointed it out in the
>>>> virtio-networking upstream meeting.
>>>>
>>>>>> But probably it is better to address it on top, with another 
>>>>>> feature flag.
>>>>> I think if we want to changing the vq properties, there must be a
>>>>> mechanism to
>>>>> stop the queue then resume the queue.
>>>>>
>>>>> How about allow setting queue_enable = 0 to stop it and =1 to 
>>>>> resume and
>>>>> force it reinitialize?
>>>>>
>>>> Yes, I think that is better suited. But maybe this is better to be
>>>> added on top, so we maintain this series small.
>>> Hi Eugenio,
>>>
>>> I have a second thought while implementing above queue_enable = 0,
>>> it doesn't provide more advantages over queue_reset:
>>>
>>> 1) queue_reset can help to stop a queue and the vq properties can be
>>> reconfigured during queue_reset --> queue_enable.
>>>
>>> 2) once the driver sees SUSPEND presented by the device, it assume the
>>> device states and vq states are stable, at that point the driver can
>>> read reliable device configurations. So vq reset should be ignored
>>> once SUSPEND is present and if we implement queue stop, it should be
>>> ignored too when SUSPEND.
>>>
>> The relation between SUSPEND and ring_reset needs to be described in
>> this series, yes. This is a good start, but I'm not sure if this one
>> meets all the requirements for SW assisted live migration.
>>
>> We can always add new feature flags to define a different interaction
>> in the future, like for devices that can support the change of vq
>> attributes in the suspend. To not steal the merit, this idea was
>> proposed by Si-Wei in a recent virtio-networking meeting.
> If so, we even don't need a new feature bit. We can just allow
> resetting vqs after the device presenting SUSPEND.
For the single bit of feature interaction with queue_reset this looks 
fine, but queue_reset is perhaps not the only feature that needs to 
interact with SUSPEND. While on the other hand I suspect it's probably 
not easy to converge on everything all at once for the moment. Just to 
avoid the lure of hijacking this thread for other things, it'd be easier 
I feel to define a pristine SUSPEND method starting with the most 
restrictive mandates, describing every possible means to prohibiting 
*any* change to the config space for device in suspension. This not just 
keeps the (backward) compatibility on the table which is consistent with 
the assumption of various SUSPEND implementations available today, but 
would make it possible to customize different flavors of interactions 
guarded by different feature flag in the future. For instance, today 
queue_reset may mostly work the best on software device implementation 
where one can introduce a specific SUSPEND_RING_RESET_ALLOWED feature 
flag to unlock/override part of the restriction from the pristine 
SUSPEND feature when both are negotiated and used together. In future, 
if there's any need to revisit this part for e.g. hardware device 
implementation of queue_reset might not be able to meet certain desired 
performance (downtime) goal, then a new feature might have to be 
introduced to define another hardware-biased means of interaction with 
suspended device.

>
> The device presenting SUSPEND indicates that the device config space
> is stabilized at that moment, ready for the driver to fetch fields 
> data there.
>
> Then the driver is allowed to reset, re-config and re-enable the vqs.
Maybe not for this case, but for completeness I found a very relevant 
question is, as your patch defines SUSPEND in the context of live 
migration, how do you envision to resume/restart the device immediately 
in place on the source host (say migration is cancelled after all 
devices are suspended, or migration failed at the last minute for some 
reason)? Reset the device and start to recover everything from scratch? 
Or do queue_reset then queue_enable on every virtqueue while keeping the 
other device states (those already populated through ctrl vq) around? Or 
suppose right now we have a symmetric RESUME feature that keeps every 
device state including the queue state in place. Which option a hardware 
vendor would like to pick if user/customer would like to have the 
best/least downtime? Does the hardware's choice matter much for software 
device implementation?

As can be seen amongst these options, there's perhaps no single best 
solution between software and hardware devices, or even between 
different hardware vendors. So instead of ruling out possibility for 
future extension to flavor other implementations, be it hardware or 
software, I feel it's probably not the best thing for now to get SUSPEND 
hard wired to queue_reset or RESUME. Device reset is the base case that 
every device has to implement, that I feel might be the only failsafe 
method to get the device out of the suspension state with pristine SUSPEND.

>
> The only requirement is: The driver is responsible for maintain
> the integrity and validity of the config space fields, because
> the device is ready-only to the config space at that moment(SUSPEND-ed)
> and the driver should be responsible for its actions, perform proper
> synchronizations, e.g., re-read.
It looks fine, though as stated above, please leave it to a different 
feature flag with another patch to define the queue_reset interaction 
with SUSPEND.

Thanks,
-Siwei

>
> Does this work for you?
>
> Thanks
>>
>>> 3) the device should only accept resetting a queue when !SUSPEND and
>>> the driver can flush the queue buffers before resetting it to avoid
>>> losing buffers,
>>> and we will have tracker for in-flight descriptors later.
>>>
>>> Any thoughts?
>>>
>>> Thanks
>>>> Thanks!
>>>>
>>>>> Thanks
>>>>> Zhu Lingshan
>>>>>>>>> +
>>>>>>>>> +When VIRTIO_F_QUEUE_STATE has been negotiated but 
>>>>>>>>> VIRTIO_RING_F_PACKED is not,
>>>>>>>>> +the device MUST ignore any accesses against \field{Used State}.
>>>>>>>>> +
>>>>>>>>> +If VIRTIO_F_QUEUE_STATE has been negotiaged, the device MUST 
>>>>>>>>> reset
>>>>>>>>> +the Virtqueue State of every virtqueue upon a reset.
>>>>>>>> Need to define the meaning of "reset" this is important for 
>>>>>>>> packed virtqueue.
>>>>>>> I will remove this as Stefan suggested.
>>>>>>>>> +
>>>>>>>>> +If VIRTIO_F_QUEUE_STATE and VIRTIO_RING_F_PACKED have been 
>>>>>>>>> negotiaged, when SUSPEND is set,
>>>>>>>>> +the device MUST record the Virtqueue State of every enabled 
>>>>>>>>> virtqueue
>>>>>>>>> +in \field{Available State} and \field{Used State} respectively,
>>>>>>>>> +and correspondingly restore the Virtqueue State of every 
>>>>>>>>> enabled virtqueue
>>>>>>>>> +from \field{Avaiable State} and \field{Used State} when 
>>>>>>>>> DRIVER_OK is set.
>>>>>>>> We can just let the device report those states in any case then we
>>>>>>>> don't need to care about those details, or did you see any 
>>>>>>>> blockers?
>>>>>>> Agree, I will add the definition of used_state of splitted vq in 
>>>>>>> the
>>>>>>> next version
>>>>>>>
>>>>>>> Thanks
>>>>>>>> Thanks
>>>>>>>>
>>>>>>>>> +
>>>>>>>>> +If VIRTIO_F_QUEUE_STATE has been negotiated but 
>>>>>>>>> VIRTIO_RING_F_PACKED has been not, when SUSPEND is set,
>>>>>>>>> +the device MUST record the available state of every enabled 
>>>>>>>>> virtqueue in \field{Available State},
>>>>>>>>> +and restore the available state of every enabled virtqueue 
>>>>>>>>> from \field{Avaiable State}
>>>>>>>>> +when DRIVER_OK is set.
>>>>>>>>> +
>>>>>>>>>      \input{admin.tex}
>>>>>>>>>
>>>>>>>>>      \chapter{General Initialization And Device 
>>>>>>>>> Operation}\label{sec:General Initialization And Device Operation}
>>>>>>>>> -- 
>>>>>>>>> 2.35.3
>>>>>>>>>
>>>> This publicly archived list offers a means to provide input to the
>>>>
>>>> OASIS Virtual I/O Device (VIRTIO) TC.
>>>>
>>>>
>>>>
>>>> In order to verify user consent to the Feedback License terms and
>>>>
>>>> to minimize spam in the list archive, subscription is required
>>>>
>>>> before posting.
>>>>
>>>>
>>>>
>>>> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
>>>>
>>>> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
>>>>
>>>> List help: virtio-comment-help@lists.oasis-open.org
>>>>
>>>> List archive: https://lists.oasis-open.org/archives/virtio-comment/
>>>>
>>>> Feedback License: 
>>>> https://www.oasis-open.org/who/ipr/feedback_license.pdf
>>>>
>>>> List Guidelines: 
>>>> https://www.oasis-open.org/policies-guidelines/mailing-lists
>>>>
>>>> Committee: https://www.oasis-open.org/committees/virtio/
>>>>
>>>> Join OASIS: https://www.oasis-open.org/join/
>>>>
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

