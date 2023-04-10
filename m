Return-Path: <virtio-dev-return-12093-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 273E6C77B61
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 16:22:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 599D177E9
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 16:22:07 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 50AC19864B3
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 16:22:07 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 45879986319; Mon, 10 Apr 2023 16:22:07 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3319598631E;
	Mon, 10 Apr 2023 16:22:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jWjcAsiQLLttPe7O/EiQFsCisH49lOT44w9av/nmdJrl0EJD3DOFcm20sN9nsntEIkS/M0EuM4N2C8uIdQNlnAiulgjA3VoI1FfSaVomg63SyJZSxqy5vywOodV2rtGKuVGo2tQHzHpBF9mx16L7MlR9lfTEUznsAO+lXeXOoVHS7p6wRyo4TWjQLDXc8k6nSHwdxQMLCRRecC7jICVYYDnRhQ71WqG4vTyXV6/r0LdBPCQaSOVtBBubSCTh0+HxNufkZLXK0esd7XoBEp09vJIlLQS0BdKy83lDvWQMXejzz6NUtsSGM9YC8yUGfGohZETDvdNfGmdh3LFPPijVvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJnrZlhSvm7Dz3fEX6dsqnSlJTxBuNpALj1PGaQ48KA=;
 b=oY0pRDsrZ+oB6WsuJ2db9OTiQUaLGMtWuvqZXPBfxVsyjmlGJEq0NjSz0LlY3oT/F7OET+MCpLXBbJ7vvbwBokDI410EhE35Q0spkwhcfU5OatAqLGcgGANRB8UqafOKBhikVKsqdkeiYetZvNssehIO9mMqjw5sjahGXKJxJcvmgdZ/kl6rjtS0a8dtPEHHQlqGWXCpolRnaUAgOfiuQyTNOHPX/HbWDAunPERZb+dxyvrC4jYRa+qspC866C9HhjNSeEn/LlKXZkCAMMkeCtiTXgxXpPy797uOial3xZixrVLGw9WZ1XTGmgRuXsP1vl1w+1MNm7fGKa/aSaws7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Message-ID: <fce3c697-55a6-1410-2f42-db6499bd8f87@nvidia.com>
Date: Mon, 10 Apr 2023 12:21:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org,
 shahafs@nvidia.com, Satananda Burla <sburla@marvell.com>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230330225834.506969-9-parav@nvidia.com>
 <20230404032922-mutt-send-email-mst@kernel.org> <87jzysjd4g.fsf@redhat.com>
 <20230404084126-mutt-send-email-mst@kernel.org> <878rf7kcna.fsf@redhat.com>
 <20230404102053-mutt-send-email-mst@kernel.org>
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <20230404102053-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0058.namprd12.prod.outlook.com
 (2603:10b6:802:20::29) To PH0PR12MB5481.namprd12.prod.outlook.com
 (2603:10b6:510:d4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_|DM4PR12MB6304:EE_
X-MS-Office365-Filtering-Correlation-Id: bc0b1928-c7f7-4c46-a6ad-08db39dfb550
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fdIKOjLLzjdi+dIxXIEMAJLsQNVkORSpKPpRexjCFE5J1kI7j44yQKNWFDdgtlmMcElUvIVldtyB9S7wJKa0UeZGKms2FlnmPcPl48he1eERxTPeu52Me1BL823e1V00lYkklA4tKa3oqzdKN1U0B3n6STgrL5BxQiNHrtA8itlEY7fpYPOpnckteo2jDfl7TMypEAI7a1nYAS0H6nR4f+1AQGmXx603EiUW0uNBHFKyndYCf6VuTuGmwy/em7XfayO5n6cJi6z/EKXidVXL1oOOxb7xfqFfTWza6kmTwe4kMfP4T1wY+9QvGBJ4xsdqhIPQStK6MbpQaVL0xnH9wYffxW1V9WevLDhIEOQsJOnP3sXRwTOnhKmAXbmBhMVgQotq6tZSeMRGMiTU2jLoXpan7GnFqCdi3D2j7Qmdx7l/9HfHqPGaT9TSNv1mecgmPJVj8KC7YrfRyInH0oExM6wPmQ87Ph9IHh35y9tsKFm9ZcRbYOUHA2kP0FsjW/BE7M+rWD1YhVhntQlLg1C4x0/1R5QpXu5wBZ2x1f7iYC0eaHX2R+eTZqWvQd/4pxT9GnZrYqZHFh88OslIdYnJsxKc2qASnCrw29nFYU99cVYR0+Jdfj7vZ8s2QhNpRdvY/80qaulVThV9sjhw1ZQdYYIfhmDj9UCeanMzt4MUipeWgt4WLHsq5A2nQ59FYh1BVOezAgCMVfz1r5m6odcYcxtdeVvdPrcPmxlhXxhsaJM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199021)(31686004)(478600001)(86362001)(31696002)(83380400001)(36756003)(16799955002)(38100700002)(2616005)(966005)(6486002)(2906002)(316002)(110136005)(6512007)(6506007)(53546011)(186003)(26005)(41300700001)(8936002)(8676002)(4326008)(66476007)(5660300002)(66946007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cEJYY0JMTXRlV1FRd2lpL0tpeDJLaGdQR2dmS3BnT1VtTVFHTmN0M3JoT0JL?=
 =?utf-8?B?VUZLSDdUK1dKamRFZm9CdGtPR1A4eDZJUHUyWGU0MnpGV3RvMGxpV3d6R0RY?=
 =?utf-8?B?Q3h5MTBYV0d4YkttUlp4bnBPS2tiR1lBTEN5QUx1cEVTbXcwZm1pSnlxdUJN?=
 =?utf-8?B?NTdCVjloMVdETEtuRWRWTDRzZC9US1hZcTJmbTF4R25weEhlNVo1QWUyakUr?=
 =?utf-8?B?R25naHc3a2J3RUc0ZmhqQ0UyME0rQzl6d0tJa25OZlU2UCtHYW92Qms3TGFz?=
 =?utf-8?B?TGpMa25ydjJnUXd0UFNLM2dUbXgyY1V0N0lHRzRiSFlGeEI5RkFDQ1BjSjU4?=
 =?utf-8?B?a0EzR1orcnRVR2V3Y25SeDZuYzVGZzh0a2dvQkc0VzZnNmh6aHJSVlpkcThG?=
 =?utf-8?B?ajdDQ1FwVlQ4ck0xa09jVkRuQTUvdDV6cGdQNDJ0Y0ZiaVFZNzJxZytHNjRx?=
 =?utf-8?B?YkEzanFqTUlDTWF4bHlwRFJrNThCL2hZM3FZQjVQVmdHYXZLcjh5S2V0R3BL?=
 =?utf-8?B?eGxRamJZMEMrRUdtWlVSc2l6WWlsTFYyenByWUt4RUVIaWRvanM3TTVpa3BH?=
 =?utf-8?B?WmpsVFdIN1djL0I0djU1dEVBaExSaklRZDJuaVZWanZHNC9SUExaWUtMSElw?=
 =?utf-8?B?dXhOWmVRamNsejNCSW5TcVJTWUdTVEc1aEtjQjBpZit2YklZWk1pMDNaNVNu?=
 =?utf-8?B?UnQ5cysvS05VZnR5SVVBS092bGVoc2RPU1RUajZhTkk0WGdwVlFHUUdzZ0JS?=
 =?utf-8?B?UUVsS3ROUm9TUWtEYWJOQ0JSWE5zYTdLWWlvQ2d4THdBMWdSQkFqTGZ2YlFL?=
 =?utf-8?B?MXdWK2MxY0JFRHQxV1ZhR20waDRpWEg2blpONm1UYTBLd0dldWZ5aFNiL1dr?=
 =?utf-8?B?VElTWWpaSXp3WUR6T2lJRDhBOWFCbVJmczlWMGpsbGd2TWhGTEZ2bmZKMzlU?=
 =?utf-8?B?NG1mYmxLMVJxNVNoWEtaTFN6bFk0TXJqTE9PZllGRGpPQnZQUVorN3lseXJx?=
 =?utf-8?B?c1pQVDdYR1l3R2xOVGJLSFdxWjUwK0NjKzE1QkxMS1lsSm9KUTFLcUtTRE94?=
 =?utf-8?B?a0I3cFZVSzVoK0hueVZ3WVpvbnN5MXhTMWNGelV5NlY5RkxpdXlIaFNNeS9H?=
 =?utf-8?B?elNWNEtQNVhGeGJQS0ZZZ052TjRJV0J3dWs0eWZ6RnI0VEhER3hzZ2FjT1dS?=
 =?utf-8?B?ZWxkMXRSNml2bUlwVDlUTmpCWHB4cjRvZnY4SVdMcWFtSHpJaHhNWnBiNUJx?=
 =?utf-8?B?MHA4WEdPNkZabWFubkd4b3kvdHBZWjZRUk5pQnhuWFN2MmhYT2tYWnVOM2Ra?=
 =?utf-8?B?WnNrVGZOYTE0WEtBeWNHSkVMZ0VhTDdxNTFaYzUvVjRmNGZtVWw1RS9KNW5K?=
 =?utf-8?B?cUcyb25vcVRTQTc5RzhuTjBTL0swSlNmME1sOFBlWTl2SlBWTkRxOGpxdEhr?=
 =?utf-8?B?czlCcEpkWDV4djJrQUtmc0xyTk5WVGhkZE9RNElHV25vUFpMMWpwV2g0NmQx?=
 =?utf-8?B?N0xTYk1KNU5WQUhrU2JxTWZCbDJwaUkyMWduT01IYjJTUkZCc3JmdkhlV0RT?=
 =?utf-8?B?WU4wSXBXVzhaT3l2M0FSZi9vb2x0QUhXclVWV2FGNFd0NklMSUxhekdBdGlZ?=
 =?utf-8?B?RDB2Q3ZTVmx2Z053WnhyMlRzeVVISWR1S1FuaVNEVmFtQ2J3N20wenNoR0d1?=
 =?utf-8?B?alFub2RCY1o0UWx5c2VTdGJ0Z0E1SjAvQWJSbi91WTl4VnJlRTFxNjdXbnM4?=
 =?utf-8?B?QjJXQzdJVU5rY2lNWUNPYVhIUVhkZEVzeDIyeVV1cUthK3hyVTFzaTJVSkpj?=
 =?utf-8?B?SElNQmptODFqVEViWVZrV0lqLzdkSnlwVTVSM2R2aEZ2c1lKYWI2N0czNS9S?=
 =?utf-8?B?a0c3TzFHU2ZXeGI3U25FT012OUJUNVlUQk5panllSVkxVTZUaytMMFovQ2Fk?=
 =?utf-8?B?cGRDZVdkaFlrQVJKcGlLVHdIdGdJNXRxbWUzd2h6M1k1UVZ3NlFadTRuaGkx?=
 =?utf-8?B?MTBPdmFBMSttampCaWhTakdOOWUwenhTeUU5SGFNMkFnL0Z5S0swUmJMdlhs?=
 =?utf-8?B?cUdlRGRaSUJYdjhJYUlZdHd0YVFwTzRmekxDOEgvam13dzEzalhaMVFsL3ky?=
 =?utf-8?Q?vhjGgmp+10CCcpicCfJhouZWN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc0b1928-c7f7-4c46-a6ad-08db39dfb550
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 16:21:58.7538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J41JbcEP92+9UndgeUq+TPZjHE1AnkcrewPD2v/QhnKvAk/Cd4pTiubuy87aV4TCHW6+AuoF6120MScdlTQVkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6304
Subject: [virtio-dev] Re: [PATCH 08/11] transport-pci: Introduce virtio extended capability



On 4/4/2023 10:37 AM, Michael S. Tsirkin wrote:
> On Tue, Apr 04, 2023 at 03:19:53PM +0200, Cornelia Huck wrote:
>>>>> What does it "Co-developed-by" mean exactly that Signed-off-by
>>>>> does not?
>>>>
>>>> AIUI, "Co-developed-by:" is more akin to a second "Author:", i.e. to
>>>> give attribution. (Linux kernel rules actually state that any
>>>> "Co-developed-by:" must be followed by a "Signed-off-by:" for that
>>>> author, but we don't really do DCO here, the S-o-b is more of a
>>>> convention.)
>>>
>>>
>>> Actually, we might want to generally, to signify agreement to the IPR.
>>> How about adding this to our rules?  But in this case Satananda Burla is
>>> a TC member so yes, no problem.
>>
>> Adding a s-o-b requirement is not a bad idea... do you want to propose
>> an update?
> 
> OK how about the following:
> 
> ---------------
> The process for forwarding comments from others:
> 
> Generally, subscribing to the virtio comments mailing list
> requires agreement to the OASIS feedback license, at
> https://www.oasis-open.org/who/ipr/feedback_license.pdf
> 
It is not straight forward for non virtio tc member to realize above 
obligation.
It is worth to document it in the section [1].

[1] 
https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=virtio#feedback

Something like,

From:
If you're interested in following ongoing development and can't join the 
committee, I recommend you subscribe to the virtio-comment and 
virtio-dev lists.

To:
If you're interested in following ongoing development and can't join the 
committee, I recommend you subscribe to the virtio-comment and 
virtio-dev lists. Your contribution to above mailing lists is licensed 
under the OASIS feedback license agreement describe at [1].

> When forwarding (in modified or unmodified form) comments from others, please
> make sure the commenter has read and agreed to the
> feedback license. If this is the case, please include the following:
> 
> License-consent: commenter's name <commenter's email>
> 
> where commenter's name <commenter's email> is a valid
> name-addr as specified in RFC 5322, see
> https://datatracker.ietf.org/doc/html/rfc5322#section-3.4
> 
> If the comment is on behalf of an organization, please use the
> organization's email address.
> 
> 
> If forwarding a comment from a TC member, please instead get consent to
> the full Virtio TC IPR, and then, as before, include
> 
> License-consent: commenter's name <commenter's email>
> 
License-consent tag do not capture the contribution by other virtio tc 
member(s) in the generated comment.

Signed-off-by captures it.

So both tags are needed depending on comment contribution type.

Rest above change looks good to me.

> If you are reusing a comment that has already been posted to the
> TC mailing list, the above tags are not required.
> 
> ---------------
> 
> We could reuse Signed-off-by though I am a bit concerned whether
> people will assume it's a DCO thing which everyone copies.
> Thoughts?

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

