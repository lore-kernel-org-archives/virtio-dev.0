Return-Path: <virtio-dev-return-11950-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B17CC7618D
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 02:57:46 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8E2DF2AC50
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 02:57:45 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 775D4986596
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 02:57:45 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6C20998413E; Tue,  4 Apr 2023 02:57:45 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 570409863E4;
	Tue,  4 Apr 2023 02:57:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=edPqf3gtMyEXAscsaQxOc0OmCa6Vw0soTb+Sujw7jsZFr7yAF4ysFjLVcKg+cg6c28rzJXsbGwwdQvXW4Eqjpes8vSNOXrFjHcQ7CcV7THahgrVDEYIBty6SwGoSrVVgb7HWUn9NNAZ01lSQ9Xixl6D/w2blixd2vFVBTclzIw+xRIQq00E4VWRHWnviOwILvOP4AE2F1zPjBBKALmDQ+lV4VvhkPs24MxWtnPY1z/FxH2UnrXmYDV9lmEWcKDwCkyTWR9ePlhAaweSao65G+e74GS7QLw3cFTi9Q34M/QwFyTNym1PJ8CYpGUQgaIFJ+IS3S+ISHgrhODpkb+v3/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FmV2DOw2O1ckulJ4boebXZa90lPm2Mt+FRW6lnJuh+s=;
 b=Ya8rf68XDXBAMp9vKQFn+UOk7myO51lKrqBvFBgKThvMux4L90kRe5SY9KG3WOw9JcxxYsYjYkN0F9sehwsiJKvmpBAcxF3JTkpqwo+21oYbxth7BzqCyBVUMshq5aQk1AkFKwf5xa3svCSSQqGST6/42bFqYfNFTFwhTrrhyPGNLSxPAvlwygFAz/bgP/bdTQQNJGTREtISMTBO5autz8fkRe3j0DSqwIFyzvtR2AXPs6JJcOt6In+ZHfq+6Qo8+ortSIXfc5zreW+qs358mFzmJDQPlQjk3OhMo8aLQnAicEfJv8ZBYz4RJO+uz+W/jcqSZskio9ef/KCSEuKpPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Message-ID: <d62d2090-de0d-0ea6-5c85-ecf19ae828c7@nvidia.com>
Date: Mon, 3 Apr 2023 22:57:35 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To: Halil Pasic <pasic@linux.ibm.com>
Cc: "mst@redhat.com" <mst@redhat.com>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "sgarzare@redhat.com" <sgarzare@redhat.com>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 Shahaf Shuler <shahafs@nvidia.com>
References: <20230329212341.465843-1-parav@nvidia.com>
 <20230330191114.77acd860.pasic@linux.ibm.com>
 <PH0PR12MB548165C4B11375F8C7EE7AD1DC8E9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230404033622.4b749f89.pasic@linux.ibm.com>
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <20230404033622.4b749f89.pasic@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P223CA0009.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::14) To PH0PR12MB5481.namprd12.prod.outlook.com
 (2603:10b6:510:d4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_|PH7PR12MB7308:EE_
X-MS-Office365-Filtering-Correlation-Id: b642a2e6-473d-4d43-49c3-08db34b85994
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	otC3AnNqeWeT025SBcppBz1O82jsRPMHlATHJpdL1412zUXw77F3pvbL2Pa0SWFrtXgUfextBm4c7/k7eobVYRnm1lfdUVy4fi1yUevRgIMrB2v3SCQtwkaPG08GSLf1nwAgeXS4uKdATTMDjkm4XVPF5ccmYwNP6YsyYW3RrY5SLk8HvI4jMm/oFDu9I7kmik/dj9ycNgqURSRXf7aywPhpSmi/xbpWj6NEBETbFTZMMDL8Nm43jKhCB3xH6QxlOPbB5QL3wkNDS+LTFkv60RASeQy63XBCs3B+gWRA/00Qb/+LVLTgV3EWodL1luXhOoMVG5/sPxJRpBtEjNeIFejv78wLp0HvbZ2bKX0xQNJXlapgWTOddEVdHX+3MdreC6LKJc+YR/sEi1FW7OWcIFNhwEvdhBRpi67dVlqqo0LyBpKwFAMhC+FQ8bABeLPnjC8KRgDYdXxFuD9rAYgqW0xhpX0Ymret64tq9wzHNkqgyItrvmfJDjtZdFa5/OaY6m6+zbHl/oIpG45yHdzKbVYVoIeHPcxPmcp7wfxsVcNI6kBps7PTvRRVVJ1vAc+lIjiH7AyLAQoskhJT0lDkNGZgL1sflZsByhc498lnIc1eK4m0h93RsLcYD/o+3UeMkebfZRiZ7mrYcxnlSJN+Hv6Fw452viWDDwr1eClPBYZO9+uBW3FBwtpZCyFkDx08
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(396003)(136003)(376002)(39860400002)(451199021)(41300700001)(38100700002)(8676002)(66476007)(66556008)(66946007)(5660300002)(8936002)(316002)(31686004)(6916009)(4326008)(478600001)(2906002)(31696002)(54906003)(83380400001)(86362001)(186003)(6666004)(966005)(2616005)(36756003)(53546011)(107886003)(6486002)(6512007)(6506007)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXNrSVdJRTdYekxzNXhaU1UwcGZFdjYyVGFFV1ZrY3dLNDFvVnlickhlNyth?=
 =?utf-8?B?YW9NUjljQllIWEtBVnRmdlVXUVBLcDBlajJiOGNKcjdEUVdiM1hmc2lhSjVn?=
 =?utf-8?B?dEN4b2IxTElVQ0VLVnIvTVkySkxRSDZtSlZ0dzNKSmloU0JNaVFMMU1YdFVI?=
 =?utf-8?B?czdyWFM1R29KT2c4WG1kS2Q3TkdOWUpGcnIrWkdGcGN5YXVuVm9ucnV4dEo5?=
 =?utf-8?B?amluUHNMRjZuSXQ2b2Rmc24zNXdPbU1zb0Q0WmpWZEp1MldPV1RqdmE2WE8r?=
 =?utf-8?B?am9WM28zRS83YWhjaXpaak03OWRuK0lGa2dwUWg4T0RlUXQ4UmF5bnhMZ3RF?=
 =?utf-8?B?dUVoOUU2UFJLSDNIeGEyMElrbXEyQ2ZtNmdrQzgzSXNoV1dFaHdmS2FoRitq?=
 =?utf-8?B?dlI5VGZiTG1ueXNCc0dxTVdWNXkrYStYN1dHMnJnSWREN3J1b3lUVkpRa1Q1?=
 =?utf-8?B?VVFPSmQvcC93U1NqOEJFRUlpa3duSXhRWG0wZ1NDUlNEL3R4M1dxbWN5YjdK?=
 =?utf-8?B?dDJMUWlXV2NWSUV5V1MybjdqdDZ4VkI0TmVyZEs5cHZrNm05YUt0MGpzdWVY?=
 =?utf-8?B?eFMzQkljT1FjTUdWWFBlV1hJNitPUERNL1dtcHFIdDR6N3ZjVUZYNkJoclFo?=
 =?utf-8?B?a0RYd0tHK3N1Z0tOVkYwM05OaXZ3SEk4NkhwRkNEYUdaRDYxVzU5dU51RjBW?=
 =?utf-8?B?Z0djNDNxZVBKTUJRVElSZU9pNnRINFNUdEEyRTZGVU90aHFGV0VPTnJUNUJG?=
 =?utf-8?B?ZnpyM1lJZU84OHRJMTAvdmRjVTFKMGFFVlovVXIrYVNQOE1nYkNQZjhBM2I4?=
 =?utf-8?B?aC91RU5sNkdGWkxscGV1SThFUFlmTXpiL2o2WldOOURlMU15alV3NHBPbmFE?=
 =?utf-8?B?L1BhSzhoUU9kR3dISWNNWU9tUENVSzB6WnNlems1TGY1V1FPbzFLVGJyd1M2?=
 =?utf-8?B?bFpSNU1XVGJoUWpqcml6aTg4SlozcHdlNFBOb0plVXo5cXA2UFZSSXRia1Yz?=
 =?utf-8?B?VFpPcnhOWE1LMnZmZTIwOUVHRUV3TzVZVC82TEp1WnY5Z29SNG5GVlk2d2R0?=
 =?utf-8?B?dEhyVFZLZ29CUWpQaGlVMjhXY2FzRUhjOUVDSXJjbnlBbXlYOGxXaUc1WkxM?=
 =?utf-8?B?UUNEcGU5MXZVVzRSMXhSMzV5WEVUUGdZMnQxeStiMVVmdSt5SVFMMlZvMFpy?=
 =?utf-8?B?QnNKd2JRN2hsdnFpVFIyRVlYVDUvTnVPT0pBQmljby9ZR3BCYVBHZHdlR3N4?=
 =?utf-8?B?Mmhzb0FYdnhQK0lOa1Vwb0NEd0RPVXkyY2dCbGt1VTNsMnlObHVxQ3NibElC?=
 =?utf-8?B?bE1Ya3BpV3czbHN3SnlWZ2hTbmw2clN6bFRwYm05MDRDbDNHY2Vpa01BYlh3?=
 =?utf-8?B?ZWMzM1MzWFVzR1JyN0ZTK0lUbHBOS205WG5SUGFnYWlweTJWSm9yNFFqaFJ2?=
 =?utf-8?B?b1c0TmI0bE1KYkhMNUFrK1NVSGJMS1JpRnMrVHJqWmJ3NXVUd2F6K0d0cGhD?=
 =?utf-8?B?MFBvcERXalZwNGNsRjBLeXAwNkZzVXk2UzJQZGt0cGg4R3hRaE5KZ05nTU9U?=
 =?utf-8?B?bkR5eFNaakVSZCtKSmFhZDVBSGJmUG5hWjB2Nnc2TFhOS2ZsZnh0QjVWcFg4?=
 =?utf-8?B?NWtveVcrWVZFMG1UNUhia012RWpVdTBwbVIrQWtmWWs1Qlg2RUtKcVR1ditQ?=
 =?utf-8?B?UVQxdHZyaHhWeW5NcjU3czRlek54R0trVXlhNlRCTzArRTliclpYUkpNQnVH?=
 =?utf-8?B?VUcxOXFDRzdUa2U1RUtzMjlPVW11S1BaTklZbnhlQmFuY0d0OFd1QXcxbTlm?=
 =?utf-8?B?VVI5U0UrYWNsOG1HTFA5NVZXY2F1dXkxdi9vN1NoY1RqVEZCcnp1QWNiR0l1?=
 =?utf-8?B?SWNGMkgyaTIzcGxmMGt2VkNrUVFsN3VRbHprOWozcVFvVEFjN3dzcG9kQ2wv?=
 =?utf-8?B?VE9qM3Vva3pVNjIwbVdabys4bGRMb0p1UmQ4UzluTVZESXJSS3VhK2ZteTBj?=
 =?utf-8?B?dGtYR1l6SXNuVXNlV2xBUnA0ZXFaWFZmNXBTcTRCNG1uOHRKcVVvUmVyZGFP?=
 =?utf-8?B?Q3ZNdnorbUQvdlQ0WHhabnZRT3hmcGltcjlYQkVIdXVmU1N1MkZFMENValE4?=
 =?utf-8?Q?HVrXPkdkPLY+aK1zh/hVPvtv6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b642a2e6-473d-4d43-49c3-08db34b85994
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 02:57:38.6403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SF92Mfqd+QSp4U4tmYbMFK+3dGWK38I7LosE8ctzN5zPb9le2ubtAchfdzMZ1+Y1j2Ph9oCjsQtFga2KVfuAsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7308
Subject: Re: [virtio-dev] [PATCH v10 0/8] Rename queue index to queue number


On 4/3/2023 9:36 PM, Halil Pasic wrote:
> On Thu, 30 Mar 2023 19:13:47 +0000
> Parav Pandit <parav@nvidia.com> wrote:
> 
>>> From: Halil Pasic <pasic@linux.ibm.com>
>>> Sent: Thursday, March 30, 2023 1:11 PM
>>
>>> Currently virtqueue number is only used in the parts that describe
>>> notifications (Guest->Host), the rest of the spec uses virtqueue index.
>>>
>>> I argue that using a different term in that context than in the rest of the
>>> specification makes sense, because in the context of notifications the virtqueue
>>> isn't always identified by its index.
>> Using single term as number is possible, so lets use single term.
>>
> 
> I don't understand. In my opinion we should use a single term for
> a particular thing, but we should avoid using the same term for
> two different things.
> 
Your below description clarifies that we both are talking same.
so I will pause to comment for above point.

> One thing is the zero based index of the virtqueue, for that
> unfortunately we currently have multiple terms: virtqueue index
> and virtqueue nubmer. To remove ourselves from the index vs number
> discussion let us call it "X".
>
There is nothing like a zero based index. A VQ can be any u16 _number_ 
in range of 0 to 65534.
Number can also start from zero. So zero based index = zero based number.

> Another thing is the what you below propose to call vq_identifier, but
> for the same reason as above let us briefly call it Y. "Y" may hold
> an "X" or a "vq_notification_data" to use your term -- we both agree
> on that so, I believe we should both agree that "X" and "Y" are distinct
> things an need distinct and easy to distinguish names.
> 
Yes. I proposed Y = vq_notify_identifier.
(like how we well named rss_rq_id).
Y = vqn when NOTIF_DATA is not negotiated (usually default).
Y = device supplied vq_notify_identifier when NOTIF_DATA is negotiated.

We should better rename the NOTIF_DATA to NOTIF_ID too. But I park that 
proposal for later.

> What we currently have is:
> * when we mean "Y" we write "virtqueue number" or "vqn", > * and when we mean "X" we write either "virtqueue index" or "virtqueue
>    number"
> 
> Now let me pull the historic argument for consolidation on "virtqueue
> index" rather than "virtqueue number".
> 
> Most of the occurrences of "virtqueue number" were introduced by
> commit 4ca1311 ("VIRTIO_F_NOTIFICATION_DATA: extra data to devices"
> and commit 2ff0d5c ("virtio-net: Add support for the flexible driver
> notification structure.")
> 
> And I argue most of them stand where we mean "Y". Some of them
> don't and that is bad.
> 
> Please have a look at the v1.0 version of the specification:
> http://docs.oasis-open.org/virtio/virtio/v1.0/cs04/virtio-v1.0-cs04.html#x1-370007
> and search for "queue number" and "queue index". For "queue number"
> you should get 1 hit and for "queue index" 8. All of them mean "X",
> because "Y" was introduced later.
> 
> I argue, it is more sane to assume that the single "queue number"
> occurrence is a back then quite harmless mistake (all we had is "X", so
> we didn't have the "queue number" means "Y"), that to say the 8
> occurrences of "queue index" are all mistakes.
> 
> Your approach to resolving the problem is:
> * change all concurrences of "queue index" (all stand for "X") to
>    "queue number"
> * change the occurrences of "queue number" that stand for "Y" (that
>    is most of them) to "vq_identifier"
> * keep the occurrences of "queue number" that stand for "X" as is
> 

Once we rename the field vqn to vq_notify_id in the notification 
structure, we are out of the mess.

> Yes that way we can reach an in itself consistent state.
> 
> I argue that the following approach is better:
> * keep all occurrences of "queue index" as is (all stand for "X")
> * change he occurrences of "queue number" that stand for "X"
>    to "virtqueue index"
> * if we can find a name for "Y" better than "queue number"
>    replace all remaining occurrences of "queue number" with
>    that new name (I agree "queue number" is not a very good
>    name for "Y")
> 
vq_notify_id is a good name that takes us in sane place.

> Both solutions are equally consistent in themselves, but I
> argue the latter is better because:
> * it is more consistent with historic usage
Well index/vqn has mixed up anyway now.
For historic reason, I agree that index is right.
But it is too late now.
Comments have not come on time.

> * in my subjective opinion "queue index" is a better
> name for "X" compared to "queue number"
> * it requires fewer changes.
>
Unfortunately not.
Based on past agreements more patches have progress to use vqn.
It includes this patch, other patch you voted yes for vqn.
(interrupt moderation), more work that Michael did with AQ in the series 
v11.

If you sum up, changing all of it requires more changes.

> @Michael: Do you agree? Disagree?
> 
> Parav, your work is very much appreciated. I know, the messy
> current state is not your fault at all. In fact it is to a certain
> degree my fault.
>
I was really fine either way for index and number, one month back when I 
asked to reach consensus.

Most agreed with vqn, and engineers wrote v11 of this series, and 
multiple people reviewed.
Followed by other two patches.

I see few options.

Option_1:
1. I will send v12 of this series to use index all the places instead of 
number.
2. driver notification structure vqn to rename to vq_notify_id.
(after merging this series as follow up cleanup).
3. Once interrupt moderation series is merged, rename vqn to vq_index. 
(really vqn reads better even though history say vq index).
Because votes is completed and voting period ended for the important 
feature.
4. Michael send v12 with index.

Option_2:
1. Continue with the v11 of this series as vq number.
2. Continue with interrupt moderation series voted
3. Continue with Michael's work of AQ
4. Will do #2 of option_1.

Please decide at earliest.








---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

