Return-Path: <virtio-dev-return-12628-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E0A3C77B7D
	for <virtio-dev@archiver.kernel.org>; Wed, 10 May 2023 16:05:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8A99933563
	for <virtio-dev@archiver.kernel.org>; Wed, 10 May 2023 16:05:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 05AB198674B
	for <virtio-dev@archiver.kernel.org>; Wed, 10 May 2023 16:05:30 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 749529865B3; Wed, 10 May 2023 16:05:29 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 04BEE986591;
	Wed, 10 May 2023 16:04:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J2lFrbQXozP+azVlrTYKkAWvz+d7UnS1Xn3WohRPmGCXoD/ZuRmgtcDbcaWrgENauHoEp7j5avNpRXZPP5uAI7vnhPNXaH8J6Xxt8p4xROc1Pn9rzqbroZAxlKs7qFn0EViUoVicDvgN6TCaTBvpvbcApE9biR4hq5ebIOb+LnVU+OpGy0/lCuxxCxDkpBvroW4sOomekCxbtANHntY9ZG0Lydfdzar6pCK9wC4ALv8YK0bQhKtJfuS1LOZPsJoin27cyDVf3LUAAtV+3i3QuyHDjt+dOnBeXLKPjuS8mZjFqBpESUjIbmLey8S6ZVhmIHyaT31CoSXHiGSnfHjIDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EuE0o1VBr1m/mlDg6QNKe+pOkMUnrr/fgJvwv0LGB6g=;
 b=IwBhHtLxUu5mmQt9SC+eJsIie4diojscZNa87MiLW4XJprhh7JbkC1HO8vCuUtONr52EQItr+ICbbcw3OloEMNzMaQ2gld249bdOjh+4qmPRHyG5xbPeZSoFQgjnKXcKgUmMeeW8MxJrVkUo7zZPY0px+lpndLOlcezDk+deTY8S5DlF48iml2wFFGcc7i69EYkc8p71RyZX12r623xVxzvdm4uj/XOs5XMmQ7U3RAb9pJ0X2I3yTlKyB81vG4e8j1fQMvbsnIvsyltq7C/rA12y1zaZg9OPfjyf3RjFKmDCJez3W98srFI5ozBvmwx6+4VTNEt5hzosMG9jybQzXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Message-ID: <d79a83db-46eb-7f7e-da8e-f39b58b1bc0f@nvidia.com>
Date: Wed, 10 May 2023 12:04:02 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "david.edmondson@oracle.com" <david.edmondson@oracle.com>,
 "sburla@marvell.com" <sburla@marvell.com>, Yishai Hadas
 <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 Shahaf Shuler <shahafs@nvidia.com>
References: <20230506000135.628899-1-parav@nvidia.com>
 <CACGkMEt_2B68a+BZ4-vfeDf_eYj5ZhxrDNd6dxuiF85qr0yN2g@mail.gmail.com>
 <20230507093959-mutt-send-email-mst@kernel.org>
 <CACGkMEtfMbcu2OPsH6P2tA1aHh2FKygv=xkJ-e1XQzb62nE1vQ@mail.gmail.com>
 <b33fe999-8491-30b4-5021-589a2fe87398@nvidia.com>
 <CACGkMEsSJVG8mzuo3BH1xQzz5TyNbO+o3GcYwoXchcYVOczTTg@mail.gmail.com>
 <PH0PR12MB5481AC52CCAE9636E17C7565DC769@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEu1oU0wzygicS0bApoWuRaWkWsPivKRiq-ghezB=hg+Fw@mail.gmail.com>
Content-Language: en-US
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <CACGkMEu1oU0wzygicS0bApoWuRaWkWsPivKRiq-ghezB=hg+Fw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0236.namprd03.prod.outlook.com
 (2603:10b6:408:f8::31) To PH0PR12MB5481.namprd12.prod.outlook.com
 (2603:10b6:510:d4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_|MN2PR12MB4047:EE_
X-MS-Office365-Filtering-Correlation-Id: eba22e88-4ef9-43b8-e6a5-08db51702dfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IZJ/7X40qb2+2eDCNpvevp/tAXhcK86kVyWAiJ/Ex526jn8KkDvWgpQMuxlsJi9PcyPtc8FzSdXrM0hsGLhaPYRG2HR8HV9czesO8yxgj/VUg2nwmlKrcZcT4hdSBNdxdvJm+3FYyQYVnAa2mPe+OzzOHcw3WdA2FgxO1zAiIf41+pXxKxbSlbiCBBY46fVhwYHSyQt/KdrK8BoEht00M67n8CtF+udHEvC5h4zPHmd3EG/dwv71G0OaWQ/8cxpTky2tawBfSyaw/MeXyXODQXuJIXEY8LsPAFvSILMAy7lpCgJi0AjNdaQeHONHXonRIPGJvEt4EIhRu+/9eCh2lcjipiOJ+szEUiwI1NeDOYQe/uGrFBw0UIw/rbG9fHppVakxw3dSltPClAfpOGXhPh+/7zr8jPGdSQ8CAZu/WrkDiUQl5JhbfC8thDrKFbwBMG8lm9wcaksUojqmfxVWSw4DIXQ1Ks0x4p9cCGcAimha2rtPXpH7Kt8tqGQwy978UI4xDwcvvSZHb79Rzu637fvhhA20wrfMxmd6oxfZz+w2lwOaqpC7XniQ4dZUIzYYzj0bC8KjOnU9k/Ga18z+CrVgnn/7UyVR/l5nqHcwrxA9zAO0LHT5pfccsp+FCXDqS2zGHW3I4gDxjZkDbetK+w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(451199021)(186003)(6506007)(6512007)(53546011)(478600001)(107886003)(83380400001)(31686004)(2616005)(6666004)(6486002)(5660300002)(8676002)(316002)(38100700002)(41300700001)(86362001)(8936002)(36756003)(4326008)(54906003)(66556008)(66476007)(66946007)(2906002)(6916009)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MlVpK2NpK3FaNjRaUnZCZGhkUmVMUnMycFc0aFg1dG5BQlFxbGpad3pqQ0V3?=
 =?utf-8?B?Y0lXaFdtMFhPMldUdCtVMk41M1o4U24yWHpHK2hrbGpBRGZXTlNGVTNhRDU2?=
 =?utf-8?B?UWlwUDJGZE1UN1A0VCtmTnY0REZTWmFBREdYd3NuRGhmdlNpUHdISkxpSklP?=
 =?utf-8?B?UXdwcE5JN1N3dFhDM1Voa2xyd29xY0JPWWl4QUJlNmI0Y0V3N205emdpVVds?=
 =?utf-8?B?OXFlbjJmT0ZEeE5la3ZpaW8vdDd6MzM1bERKM3ZqcjZncTM5enN0YTlnbERJ?=
 =?utf-8?B?WGFyWmg2Wi91MWxVUDlHZjJ3dVNaM1VlRUhMRjZkd3lib2ZhVlIza0pLalcw?=
 =?utf-8?B?a3pMcUZmdkgwMytob3BrZ1h1REMyaXJEZXdzZnlKVFI2bmsyOHNzZ0xpcUlJ?=
 =?utf-8?B?Ujl5NU9jLzRkaXArTmY2NnpKczNCTCtCNm41ZFdmQVhOakFSaVJZWkQzYjhY?=
 =?utf-8?B?NEl1MTczUWN0SFF0UE1HSEYvejlOWEZwMlB1N2l0U3NGSGZQUEo1eTc5SzFJ?=
 =?utf-8?B?RFBFUzFuRWFZZHVtNkIyY0ZUSnphQ0RkYlh4ekt6R1BCbkxzTDcyTWF1bjN1?=
 =?utf-8?B?RHlPSlBWS21VMWRqQ1IyMmFTeDVsNkJBd09YWXVleEJNTGdxS1o1T1UrVHdy?=
 =?utf-8?B?Vmx2Sng1OUZRd29PT3FKbWI3clc5WUV3djdJS3c4MFNzVXIyRzBpc2FZNVZ3?=
 =?utf-8?B?MlA0eVphdnFmazdhdFRoU1ZLSnhRN3F5aW1tSnl0MGljQldlRlhIMGVEQmNV?=
 =?utf-8?B?RWhGNUs0Z3JaUmNPOEZtZjExUEFXTEJieHRDTlM5YlFRUko5cy9Ncm41RVo2?=
 =?utf-8?B?dHZmN3FteUxKL0ttZmNKaVhaNmplY3ZsOER1VE53V2w0bGxEc2o3RnNuNlEv?=
 =?utf-8?B?TVdTNFEzT0dzQVdDWDgxSkFsVmhUMC9SR3d3R0NqOFhYVmxVWUhRK3BJQ2lo?=
 =?utf-8?B?R0crWS80VTFtUDV5STNzMlNHZUl4S0JzdXdDY1ZUYnRNK0JLSG52cU41Qlk0?=
 =?utf-8?B?R3FRS2lTN05Pem80K2EraWZzaTErQWl0TmVvQ2JQNmM0NTJ0RzdPbDd6Y1Ey?=
 =?utf-8?B?QjY0dDU5M2d6TG83YXJqMXoyaU9uU1hZRjNKcFFVTEEwZzUvOVlYSkkwaEpT?=
 =?utf-8?B?NVRSenk2K0VuV0dWdUF2dm5FQTJtdnAwT1BDQTFoeUZwUXFhS2k1Y1d4L01F?=
 =?utf-8?B?YTlVeW5CbUYrYk9qYWdJdHF2U3Fub3NLdWRJUVM0VXJ2dGpLeWlwWmRDK0py?=
 =?utf-8?B?SDVNamNZeWErTG5yY2pRWUZpa3dLWXluZ0ZTWlBWb21NUk9XY3NuZDUvYjg5?=
 =?utf-8?B?ejBsZC9RM0pTWG9WOUQxREdub0c5Z0l6V1l0ZisyUFFZc3ZvNHh0UFNjN29U?=
 =?utf-8?B?dVlKVk8xdjQvL1NwVGdVME96eG5EQW5aTkJsMkg3d2Q2cHYraTl3Z0V4TGM1?=
 =?utf-8?B?N3REWFArbkk1L2NJc2RuZWZkaUtEUDA3QXpxWS9VOEJGYWswaGlyOXU2UEZo?=
 =?utf-8?B?NUtLTWxJSi9YR0tSU0Q5bjJxZDZXZzNVUU5GbkNCRmVrVnJuYnBmK3lReXZj?=
 =?utf-8?B?WmVGNHdNcE5FM2V4UUxkOWJ3c2VEemhicSs4MXhHTEZKVytvVnozcnFOY3Ur?=
 =?utf-8?B?TzNtdVZmeG50OWwzaGJMbm9BYmliRnhRMGlPdGlWVXZpeGRNZk0xby9OOEdM?=
 =?utf-8?B?SDlyc3VCeUZQVHFQNTU4RGdFbVFPWTdVMEViMUNUaG5xRG8zc2R2Q0trYS9j?=
 =?utf-8?B?OU55R1ZaREJUUVpqemF5endIZHc4c245Wk1SUnBpanVpeHRTaFJTb0dUQVNF?=
 =?utf-8?B?V3Npc0FIZ2RJSitDTStySXBYZEI2N0dXdFgvYWNwS1hwei9CUFpjQm92SjRT?=
 =?utf-8?B?RnQrUGZwMnhzS3pmZ1lhQU10a3ZXMTl3R3JzVWdJZnhiL2NLc2pmeldkcmJL?=
 =?utf-8?B?ME1qemMwVVVLNEtwSTFnc2lIeHZtQzIyTUNodVBmeEJZYXhiY3JrYlB0eFBr?=
 =?utf-8?B?YkJEWER6czZOaW9OT3RKZ1B5QU5OSjVkR2hjeGNldnJhNExPQTVidW41WFo5?=
 =?utf-8?B?T2dHUHlBUkEwMlhOTTdLVkRRNnI4bk94ZFUxSHhuRTdrRFdwa3JEdXlUWTV2?=
 =?utf-8?B?M3RYb1NrTXIyd2hSZmZKNEMwVGREMGd0MDJ2T3cyTGJwOGl4Nm9lanMzdE40?=
 =?utf-8?Q?IZdJKBrmkpYYPVlqeuz1/bgzxN9DpnqlIO3y1bDNJMeG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eba22e88-4ef9-43b8-e6a5-08db51702dfc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 16:04:05.4803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2OMLpHv0OsjekgDs/jTpbJD3TMidiKLZerbQ+2q0diRc/e2I8A+higl7Oyvjw9JsXT+UjzHDVqVpiVyXUt3hBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4047
Subject: [virtio-dev] Re: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ



On 5/9/2023 11:51 PM, Jason Wang wrote:
> On Tue, May 9, 2023 at 11:56 AM Parav Pandit <parav@nvidia.com> wrote:
>>
>> SIOV does not require mediation.
>> Composition is optional like VFs.
> 
> This is not what I read from SIOV spec.
> 
SIOV R1 spec was defined by _a_ vendor and it is undergoing upgrade to 
more practical use now. So we should let them finish the work.

It is hard to comment in this forum about it.

>>
>>>>
>>>> Hence, the transport we built is to consider this in mind for the
>>>> coming future.
>>>
>>> For transport virtqueue, it's not specific to PCI. It could be used in a much
>>> broader use case.
>>>
>> May be.
>> More below.
>>
>>>> So if each VF has its own configq, or cmdq, it totally make sense to
>>>> me which is bootstrap interface to transport existing config space interface.
>>>> The problem is: it is not backward compatible; Hence a device has no
>>>> way of when to support both or only new configq.
>>>
>>> Providing compatibility in software is much more simpler than inventing new
>>> hardware interfaces. Isn't it? (e.g if we want to provide compatibility for VF on
>>> a SIOV device). And inventing a new hardware interface for compatibility might
>>> not always work, it may break the advantages of the new hardware (like
>>> scalability).
>>>
>> What I proposed below is new hardware interface for new features.
>> Not for compatibility.
> 
> I'm confused, the proposal is for legacy drives so it's for
> compatibility for sure. No?
This proposal is to get legacy devices to work over a PCI VF.

a configq/cmdq discussion is for new features for PF, VF, and SF/SIOV 
devices to work in _non_ backward compatible way, because for new 
features there is no such thing as backward compatibility between guest 
driver and the device.

> 
>> Compatibility is coming at a cost which is not scaling.
>> If you attempt to scale, it breaks the future path forward to go without mediation.
>>
>>>>
>>>> So eve growing these fields and optionally placement on configq
>>>> doesn't really help and device builder to build it efficiently
>>>> (without much predictability).
>>>
>>> Config queue is not the only choice, we have a lot of other choices (for example
>>> PASID may help to reduce the on-chip resources).
>>>
>> PASID is for process isolation security construct, it is not for transportation.
> 
> I meant with PASID you don't even need a BAR.
> 
Not sure I fully understand, but my guess is, this is coming from 
mediation thought process.

>> Same, SIOV and VFs do not prefer mediation going forward in the use cases we come across.
> 
> Unless you don't want to provide VF compatibility for SIOV.
I do not understand what compatibility is this between which two elements?
VF has its identify currently and SIOV will have its own identity in future.

>>>
>>> Just to be sure we're on the same page. The proposal of both you and mine are
>>> based on the adminq for PF not VF. The reason is obvious:
>>> adminq per VF won't work without PASID, since it would have security issues.
>>>
>> The current proposal for legacy should be seen as separate and not to intermix with per VF based configuration queue.
>>
>> adminvq/config/control vq per VF and SIOV both devices will work without PASID (unrelated to legacy).
>> Because they are like any other queue, such as txq, rxq, cvq. All of these queues are non-mediated today for PF, VF devices.
>> (And so additional configq follows the natural model for config space access).
> 
> This is only true if:
> 
> 1) you don't want to provide any backward compatibility for current
> PCI transport, 
There is no concept of backward compatibility for new features.
There will be new driver anyway in the guest.

yes, I don't see a point in mediating 1.x config space for existing 
drivers as it is requires mediation.

> this means you need to use new drivers in the guest
> 2) you don't want to do live migration
> 
Not sure how you assert this.

Live migration at VF level for the passthrough device can be just fine 
without any mediation as long as all the parameters on src and dst side 
match.
We already discussed in v0, so I prefer to avoid this again and focus on 
the patch in discussion.

> If you need one of the above, PASID is a must.

A PCI VF passthrough device LM without mediation is achievable without 
PASID for all the existing defined features using config space.

and also possible when new features are communicated over configq/cmdq.

Transporting existing config space using some additional queue is _not_ 
the objective, because building a scalable system where device has zero 
knowledge about needed backward compatibility is hard.
I provided the example of 100 Vfs with 30 and (30+40) bytes config 
layout previously.

Yet we are repeating and diverging from the discussion, that we should 
not intermix:
1. How to access legacy registers of the VF
vs
2. How to access existing or new configuration of the VF

Because both have very different requirements.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

