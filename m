Return-Path: <virtio-dev-return-11548-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5973C64EC4
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 18:16:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2601641EE8
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 18:16:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1F16A986701
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 18:16:17 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 138069866F0; Wed,  8 Mar 2023 18:16:17 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EEE599866F1;
	Wed,  8 Mar 2023 18:16:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ESK2P8yAcWCVo7CluWWWmGNYKlDQhsO3PVv8AJWXL4BXcBKdmCO00os5Pz28SPpNLeZDxG7YdttiTULdfTFXMTITXJi5SARB248Z1QHiNdOKZxfcE4aRxS5OsmhbTFYnwL1Ek58GQPNwEQA5/+4o48V8uIy77Cv6OOQPJ8nqep8hCuQf6C/En99GHIsMXtRHzGM70rOIw0tEhz/EA/y0bIsgvYl03yPX/LABaD0FBvNK1doIA0cfaCx+wot9w4ZzZfaDFqWSaqDK60HjwRJ3+GXvgGqodcXdl8793FXFku/sGP9R6cqq8CgYVzYzytQYC4OXuYn+D82u4laBQeHxwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxj4VzmiNoljBZ93USpKM6YAr+WkwfziKWRyyGU/sdE=;
 b=WGWnGfu/w+VKChLqym9hS/0tnvUCA6rxoW2C2lZG1LWInTAIvbmwyTrZwqR3QtxT7JScm3BsWGDbR+s8q/U3G8QWkzvjYG+Pws4xdEoSy3SKRx0w6Jj5K50EuwH5EwZJboneplwfTR+y2yVnUBlFKJ4hJrvB7A5ZG51N88ZWm3PVVi365cPYqchK2TL52h8PEfzw9nI//xqYhGmqLoKsL7sbgAHgjoXiDgvZbFp6dAOKMkfr9YQxhvjmx9R248ehvbMVZcqISd+IIb74xDdtfXauwWI8IW8kIRGlvfTZQpRBu/1DMtt/GTYfLgkPpopp3/F55KQaKbOK03uSoealPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Date: Wed, 8 Mar 2023 19:15:56 +0100
From: Jiri Pirko <jiri@nvidia.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org, jasowang@redhat.com,
	sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com,
	Piotr.Uminski@intel.com, hang.yuan@intel.com,
	virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>,
	pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <ZAjQ3N2XyZ4zD3Z2@nanopsycho>
References: <cover.1677761896.git.mst@redhat.com>
 <ZAXcqqdwfoLokT2l@nanopsycho>
 <20230306175020-mutt-send-email-mst@kernel.org>
 <877cvrkxxj.fsf@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877cvrkxxj.fsf@redhat.com>
X-ClientProxiedBy: FR3P281CA0180.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::13) To MN0PR12MB5979.namprd12.prod.outlook.com
 (2603:10b6:208:37e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5979:EE_|DM4PR12MB6181:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ac34cd4-6044-4e97-7292-08db20012e14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	m7ILPFs7Twhapx6+jNRF9J4CeSfUHotxxmkDGeuhE9vY+MIgDV3JFLtd4PnsYkwk5JMF5SpsltkkoLM3D1LvHY+WDEunPOcc7OJ0QJrEIT9eKdizfXm9vRTWWKr1S56TK1g22EBG/EU7cN4gm3JJ7/sQZDKANgNQkWbncHa1c5zreXjJDbxndX0Fnz+edIw2Wlk9KlA7pC5q5mxtDu0ivP0ijfInyglzesH3DaYKJkm10M4gBOvWADZoDLR0I9ZBm32uIb3DSJg5LfDQy2lqt89QKUg1hTXFhKjtexeuQhOmHtG3dxmhI24yHYV+BMn3TMMLN3XFYNLMRaNyj2WgmIBN+wuDVIH6pHdYQ3EsfZ2tW5a941Q+bs57pjtJyAKfCxblkrAWJItCZlbTKPKbrXuz2FqYBz04C3GquHR2GjKs2kKLt0XxiggqwkaRCw80o7wFMyzJTh69UFOPdJglnl0PDeTfSf1xawQP+LPUsJDlRWp/tXkCbV1dhpcUxYdYeCdsekn2zUcR8qsVzmuY6Y7yXj+BTE68uRaKsBL8GnUVRNTA+idNGDnS8iGMQ0YgtLrehES00R3WjzjwD+nN4PVExtJax9XMSzFSwpvIo1j2V9ePdO9slZcyBObWoo3jOU2mvsunDNt6reHNB+sheA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5979.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199018)(66476007)(66946007)(66556008)(6916009)(8676002)(4326008)(86362001)(6486002)(5660300002)(54906003)(83380400001)(7416002)(33716001)(316002)(8936002)(38100700002)(478600001)(107886003)(6666004)(186003)(9686003)(2906002)(41300700001)(6506007)(26005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j/bQA/AW02v7zpzvwu3gymFbO/E6wHa5g1FTksS9YyeXiZQGc53Xvxaeytov?=
 =?us-ascii?Q?SJyuANSsjzeqKroR9CX4peusxGY+/V3UeP4IbW+HB99JzlcBGExxG5ERGTq4?=
 =?us-ascii?Q?DjvwkIPMOvNFW6DwC01Di9Ea+ThgCX/MX5C2GvaVsHSKiTJGeHuKYdKdNkg1?=
 =?us-ascii?Q?+ZG5No/rPiaJF/c4aMb5uLhm7nrAs7O6QuBod6TL2qtsVsEwiJ7gsG5W1KPr?=
 =?us-ascii?Q?AMr6E3nWDjPb8z/1RnTKoXQEv7Et4YVxeFMbPeej88MSLlHir3GKH75kZq/C?=
 =?us-ascii?Q?/eF10m5mTgbOWnKvLFIBkdV0eufpll0GgZv/rg3cz0wdRSH1Fm2pdIE/EP3X?=
 =?us-ascii?Q?9eNBcqOeK+A0iNWVEL+zAG1xIIV3R8LUVsccqyKezE+K2F9+tBBn5vv5pqgD?=
 =?us-ascii?Q?37FjutyHu2n0L6C7eLDY9/R0spUKEW0WOdx2C3ym2xjiwfVlcAM36DRLE3wA?=
 =?us-ascii?Q?mdTifuHl5wE0xHH1ZJmqyGdum/1cKFfHt7xz2h/aHwClfuM31fro6xVCKRj7?=
 =?us-ascii?Q?iPEJ3+bsdW5BXQYriy8cHNiG5LzxQn8gXMCx98ppbbEf1UoaYBsidPiu5+nw?=
 =?us-ascii?Q?OW9E9zuPUH4CJ7om1eavOx/Q6g3siwkkBjFil56AxxA+p2gC+O/TImxz6C4P?=
 =?us-ascii?Q?MgtDeaVR55yfexJe121cuGXJPc5BeJSaIRiB6qoaKK5mbJDrTM0xEpmuYhRd?=
 =?us-ascii?Q?LZfGQDcFeKfFh7O7mCvMKnY8+Zsd3nsBN/8k/tV8wfEuZllfkNhg5rfnsNFt?=
 =?us-ascii?Q?zJecE5i6Gz5AXMo3P8AFRDKbElRmuJ2BIfSZ6c4B1AfA31AlFq+fXGjVpMBJ?=
 =?us-ascii?Q?bcL1/oq4eZstobc/UPHH5LvDNJvC0S9II0RPyvy0Odg7kKDF70md2uOVO+Wz?=
 =?us-ascii?Q?xU9mHTEXfS4EUFuoLMVMIbrMQkRrwWzfQQOdKvZalncS5rnbNqSogf+SvQ0k?=
 =?us-ascii?Q?zGsIQ2Rn+hxGS07pkYP96jrqDnMxbSLkk38svQON0VuIgq1nmxhWfmGa3rBA?=
 =?us-ascii?Q?Vw1iGbTcA0Tiw+BaDR6Bg2iPGWVjivIEfYsos606IA8IsAQ/o3tk7YbvuH3e?=
 =?us-ascii?Q?PkO68S1PBjgFKKNpKKmyM4ZHS4CyYcKof6Xn4IJppPMxQrHRy9hqylZoNWPz?=
 =?us-ascii?Q?4IYLHYNgcUx4KVNwQNKiMxlD3YK2/xsmDl4H6YzOKp4pnAQOWf7icPpC3xWu?=
 =?us-ascii?Q?NpX4V5ZtXFJ0Oq/tbHOowD6COagPiXeCpC17mVL2oRsr2440gUhhkFGBDOyM?=
 =?us-ascii?Q?5MzukYu77ck/ECMLkOPd/J+hk5Lw18Zu8XSxgDEKGVWDzt3JXAthLpEia5Pc?=
 =?us-ascii?Q?kf7H0gas9FMAx5YCWQEKsEsC25sKkUuo60EsxJ4s7IKbitOiz2Ff+VTPNKve?=
 =?us-ascii?Q?wr3Wy576gOHhRZYo+EntBBtYVxc8ylLydaEI+cVc2Iw8+m5ug7e21bJIUeMq?=
 =?us-ascii?Q?TW2CqkWCX+iGM/vrv0Rozl3gR643lH64P6ilT8JIxdp23/IA+5pQihZzy9vC?=
 =?us-ascii?Q?x78Bs0fze7/jHAZz7bmM+ic9EQYYw+DnDedSFfbEPiOe69w5EDgHdJLUJWuW?=
 =?us-ascii?Q?0M8tW3BBCZp/K4smwTmrgWiRspWkMuEUqnutBmhW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ac34cd4-6044-4e97-7292-08db20012e14
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5979.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 18:16:04.6017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gHY7h0r8KUt1yQAWO7lVpMy+HdcQ0wnn6kX7cE4wpSr6NdQ+V/cdhvpJiQa1vpl5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6181
Subject: [virtio-dev] Re: [virtio-comment] [PATCH v10 00/10] Introduce device group and
 device management

Wed, Mar 08, 2023 at 05:30:48PM CET, cohuck@redhat.com wrote:
>On Mon, Mar 06 2023, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>
>> On Mon, Mar 06, 2023 at 01:29:30PM +0100, Jiri Pirko wrote:
>>> Thu, Mar 02, 2023 at 02:04:48PM CET, mst@redhat.com wrote:
>>> 
>>> [...]
>>> 
>>> >
>>> >TODO (maybe?) - probably ok to defer until this part is upstream:
>>> >
>>> >	Add "all members" member id.
>>> >
>>> >	Add commands for MSI, feature discovery.
>>> >
>>> >	Add commands for transport vq.
>>> >
>>> >
>>> >My intent is to try and support both SR-IOV and SIOV
>>> >usecases with the same structure and maybe even the same
>>> >VQ.
>>> 
>>> Sorry to be late to the party, I'm trying to catch up. Is it common to
>>> have cover letter for features this brief? I mean, from the cover
>>> letter, I'm totally unable to understand what you are introducing here.
>>> 
>>> Could you elaborate about what you are aiming to achive with this?
>>> Could you shed some usecases perhaps?
>>> 
>>> I have to be missing something obvious, but I don't get why any notion
>>> of SR-IOV could be beneficial for virtio.
>>> 
>>
>> Good point, I'll add a bit of motivation.
>>
>> For SR-IOV, it is not unusual for PFs to excercise control over VFs.
>> There is interest in the community to include an interface to allow this
>> in the virtio spec, when the PF is a virtio device.  This is what this
>> patch does.
>
>Unfortunately, information in the cover letter does not make it into
>git -- should things like that go into the github issue (and into the

Why's that? Can't you have a merge commit to include the cover letter,
as we have it in netdev for example?


>ballot?) It's useful both for reviewing (cover letter) and understanding
>the rationale later (github/ballot).
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

