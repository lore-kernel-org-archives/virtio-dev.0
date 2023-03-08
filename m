Return-Path: <virtio-dev-return-11501-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3545CC64EC4
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 09:50:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 70C0E2A8F3
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 09:50:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D2C8F9867E2
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 09:50:32 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5CB399866EC; Wed,  8 Mar 2023 09:50:32 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3C74F9866E7;
	Wed,  8 Mar 2023 09:49:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTGXdVmgrt2BrjiQxRO+rotfm6Jel1hQXWXM0sqq1gDcuQ0kNnmtR8BqA/f4ouk+Ggs9MCBVpqKSU6oQddzX9u9toTX1Rr/bLB1p59SWDsqoMKkd4jYjoReB0F7Y0W/6mRAIObCM5iPRq+yx9178Ep+wnYedXDwKk7o0lM/TLX0M4PZNP2UCdNRTIH2tA5LbjF6tl4809+3iwval70wKIaqSS29Q1hel2dHOtDOGUjKNRO48l4Ycyu0hNQBJowMTrNMwFM3v0/4NGY/KTrHnohdW6oMwXpPT4mK5S0ID+yuHN0VHPfsPYxK6L6ocOVczI1xi3HvG/QO2xt8f8QJwtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Grr6lKHouBrA57RdsuzWom7arW+39pQiCjpVYL+Izh0=;
 b=UXA2pKJ2iRvC0wHKI3M1Bfs29aZvZ6y/V+ZWYH1dzATfuubkNVfptFQeufmMrPZTv5yq/Xx6QcYysIUSv+qGYsUTqWoAd3HoXMh6W9zD3pe9GWZvw1oF4U2LaKifao53csLfmQSXJSGkkpuC72DODytGKjHDNeIY8R6Vym+yJ1GbX4pYL3DgrK898X62s+zIv9f2ZCEPL5cGxzHn/KVrlzS4/6cna4j1l1ddll+v/+DZlvFjrcXpI5al/WH0QSESK4SmDaTv6DDmnrCaI8DKCGIj2YnXLSsaEYaxnuo13vDJzEICaL32nrgKlUorMjjfnyYYDsFi5uRL2q5FRwE+dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Date: Wed, 8 Mar 2023 10:49:20 +0100
From: Jiri Pirko <jiri@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
	stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com,
	hang.yuan@intel.com, virtio@lists.oasis-open.org,
	Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
	Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <ZAhaIItEfqQXWTGJ@nanopsycho>
References: <cover.1677761896.git.mst@redhat.com>
 <ZAXcqqdwfoLokT2l@nanopsycho>
 <20230306175020-mutt-send-email-mst@kernel.org>
 <ZAbmEmwsMMxKJqeB@nanopsycho>
 <20230307121529-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307121529-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: FR3P281CA0127.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::13) To MN0PR12MB5979.namprd12.prod.outlook.com
 (2603:10b6:208:37e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5979:EE_|PH0PR12MB8151:EE_
X-MS-Office365-Filtering-Correlation-Id: 962203c3-c0e2-4618-47c7-08db1fba664d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	a2zaNi4D53iLVDWXjiBAQcUqi4Y2+1Opt0hINM+4UY4rM+/5v+UztRw1Q/HPhSFetgHg3xQzqVVDZN89aZPYlCdIwsx/5RStcTW1T/2QFeqsM+lKvmANfH3Z0pJJI1jjWfzz6ZSRWnK4IvlbRNPyZREUqZBLXk6FpfnU4Hx5X4XgoL/jRwXTNYhc328Vm4lOUtnoax/Yya8U3JO/RyXQV9mQMajGYmHseZf4WNA850SUi2YUKOGa35NsADSjkVk2aMhStWCih6kjlma8hL2NPLq8oSbPc8JIPASjXd7/dpKwVPykEHAtcZJ4lYIIUDTdkMSeEgvgEAyYvMdOmZX6hX/1V5bahyLbZXMN9PgPrac1i1lnw47ElicwIWMfcEKBMk+PDwNJWJuOdGmrZiuWCxTH7RaHqdRkmDNMTrNwam7ZGThlYbIiwwqi6lo1JaSDjfa056U23VT/RaWBFAYlh/ewOkizylAPPP0idX35OzQI8bhB4uXjieCko8QcaQanqjt6/j27H/DBX0So+ow4cFCt1zHFN5coGa1Q9LMNQlvMheBWbCDz7vriAMNB/ayrnWNv1+7kcmCRulYOFj8CC0vt7pIWtt2DQUsU94Ss0iJv2lvddES1dMDSd5dgaNPUmdO5p3LbjOYdmg72TicMO1rBMuZ9TIxO+BmhMsrT8bJMqnm7/qTzmi5eSp3jVXQQIRMxSs0hLwVIl6sHQ2oFCtX1+2ykD8OQyGCkkEUbH+8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5979.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(451199018)(5660300002)(86362001)(478600001)(7416002)(2906002)(6486002)(966005)(83380400001)(16799955002)(6506007)(6512007)(9686003)(26005)(38100700002)(186003)(66946007)(66476007)(66556008)(33716001)(6916009)(8676002)(4326008)(8936002)(66899018)(107886003)(41300700001)(6666004)(54906003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XZvxfk70Nr/I0yh2T5RE8QzpvLc34Hb/Dh1nY8lqPN6xV2xCIP85OcLl/Q9K?=
 =?us-ascii?Q?nsPNQzancGm1BLDcW7RErJ22Sz7uN/trJN2NNtuWYMxbawO6Wpuug96+bAza?=
 =?us-ascii?Q?jNt7f7iA4DN92GlYeU5WQSu1sEUEcaS3aRom47rjnaFxuOYDYG0ag1s7gPoI?=
 =?us-ascii?Q?NE9aXbYb7Cz8k0yB+bQ4jvAlnF6XcNoPuIFr9pWGYkI0ahm3/ne857XuGFpp?=
 =?us-ascii?Q?AYQDtLEA1oKKyTT9xARDDHtBcgXrorRycNXpUMNkSSzXITSDeccdy6bv5OKZ?=
 =?us-ascii?Q?p3ExNzAYY/xKc/mqo9BzVd4YjmeOPHP5iMMFcckxm7NGVL+z0okbNFq7UHpF?=
 =?us-ascii?Q?MLcoaluH0/Bwqkmtddn9ztGOn65krYrD5Bb6ozfT4Krbdpe2VNuDda9RuVFb?=
 =?us-ascii?Q?ljaMEtrTy0q7zgEBN1dRatWAnRqC7ZbqwjYBsevdf56ODAjau3tKsAgQFPb2?=
 =?us-ascii?Q?6/Q5Y+ZHlW5idVw8TB8vnJlH3KwEuFXpRSTywvrwXfHYTmWreFlk2P6ptIj1?=
 =?us-ascii?Q?EqqM5GQK1BUVoQ8MlltQxPDZ/7se12moLg4ISQ30l6oQwz7Ppa579wnIpcVJ?=
 =?us-ascii?Q?GiyPUOYWa253I67f+ujvG0CSAl6raSbeutYzNtoFPZDny+Ep+TwxT9iWBEHl?=
 =?us-ascii?Q?51aRScujCscKewSaWM0ifkrgHdkVer5dNIVwPXNpGhSL9/ZcQKmqh4N/vBgJ?=
 =?us-ascii?Q?zHBuwVJXZa6cHW4eE3m6/uBnJDVWev1Az7EnPTmRgUFEYsABxe/varmuY6z5?=
 =?us-ascii?Q?ug0t9mSAonysp9diwiFh3tR+c8Xp4WIRmPzFdmSXSY2DJ9cExwLbvvK1Qem0?=
 =?us-ascii?Q?Xh4XECeGESXReEaklA2n+x9vZmJjZ3rUe6JH04wbEDGS8ntXLNlxaHlO6EvD?=
 =?us-ascii?Q?f7vIGBhZIR8hsfxM2G2cXWwHCi8gfxah3bAOkVHkny88DJ4kCSY4o0K2v4rQ?=
 =?us-ascii?Q?idpvoxlsOCEoEB9wZPeyx85rSUrTP4BmsnSGSmRoF9vl8Z6AONWoLY87hYj6?=
 =?us-ascii?Q?IkCTovZO7rRlmXm6nbCclRkFY1FI3By8BdOdKPWbyELkt92wi/mnPoLSV3iY?=
 =?us-ascii?Q?nJuce+KX4cHDPQJ71vIa3foKKI5MKa4fwqrACB+W9Jvj8RoiAT7szhW5co89?=
 =?us-ascii?Q?jhV58F+UidGEDqDMdnJxcckNLVQMTQ6dk23oBkgHM0urvItg71gqYs9Mi+UN?=
 =?us-ascii?Q?sHoQVABTpgSo+k1p71+vaIze6JD8/m+Y6jbTf+0FqlmhDpjScVxnsJpePYYs?=
 =?us-ascii?Q?9U7fYoo9dmKIuQmk6SCiLk0tExMGwjm73cyRzSmWXrHQw9QpuGJ+drLH65UD?=
 =?us-ascii?Q?NY9mPs3rCuzYAXdyJk3QoUbbU/FwywCWMy+KRrKyGkf4JBl5kN6W7GnyPfDt?=
 =?us-ascii?Q?3vPqsh6iYehmjNOhETyTqxQhr0nM3kr0yygdMqJtIO6gS73XnNrDeLpOELeS?=
 =?us-ascii?Q?K7McXhfN8dkj3hrMwpbKsk22nEbJ2AoIqq0h2LSfDRITAUZPwnOsJdzZJUCV?=
 =?us-ascii?Q?hgsHizN6OZa0wClnBecE/qi0OM5TPKt7bM1diPVsF2K44kr9NyH0zEhLG+Ph?=
 =?us-ascii?Q?YZcjwsIADnRm2/I3GSnJEC/2qKPxRMqpByn15o8L?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 962203c3-c0e2-4618-47c7-08db1fba664d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5979.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 09:49:24.5494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0pqlmHIrEKxI2lty2pKJw9oZtd+2sXQdrd3BchiOn3GWgSo3LLHOn2nRmqUJPHDm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8151
Subject: [virtio-dev] Re: [virtio] Re: [virtio-comment] [PATCH v10 00/10] Introduce device
 group and device management

Tue, Mar 07, 2023 at 06:20:03PM CET, mst@redhat.com wrote:
>On Tue, Mar 07, 2023 at 08:21:54AM +0100, Jiri Pirko wrote:
>> Mon, Mar 06, 2023 at 11:54:45PM CET, mst@redhat.com wrote:
>> >On Mon, Mar 06, 2023 at 01:29:30PM +0100, Jiri Pirko wrote:
>> >> Thu, Mar 02, 2023 at 02:04:48PM CET, mst@redhat.com wrote:
>> >> 
>> >> [...]
>> >> 
>> >> >
>> >> >TODO (maybe?) - probably ok to defer until this part is upstream:
>> >> >
>> >> >	Add "all members" member id.
>> >> >
>> >> >	Add commands for MSI, feature discovery.
>> >> >
>> >> >	Add commands for transport vq.
>> >> >
>> >> >
>> >> >My intent is to try and support both SR-IOV and SIOV
>> >> >usecases with the same structure and maybe even the same
>> >> >VQ.
>> >> 
>> >> Sorry to be late to the party, I'm trying to catch up. Is it common to
>> >> have cover letter for features this brief? I mean, from the cover
>> >> letter, I'm totally unable to understand what you are introducing here.
>> >> 
>> >> Could you elaborate about what you are aiming to achive with this?
>> >> Could you shed some usecases perhaps?
>> >> 
>> >> I have to be missing something obvious, but I don't get why any notion
>> >> of SR-IOV could be beneficial for virtio.
>> >> 
>> >
>> >Good point, I'll add a bit of motivation.
>> >
>> >For SR-IOV, it is not unusual for PFs to excercise control over VFs.
>> 
>> I understand the concepts of SR-IOV. Yet I fail to see the need of such
>> concept in virtio world. SR-IOV is very specific solution for PCI
>> functions instantiation, and I believe that it is already considered
>> quite limiting in many aspects. Does not make sense to me to introduce
>> it for virtio. But again, I may be missing something crucial, I just
>> would like to see the motivation, needs, usecases for this crystal
>> clear, which is opposite to the current cover letter I'm afraid :/
>
>First people are asking for it because it's out there, however limiting
>it is. In fact Nvidia is - why don't you talk to Parav here and tell
>him that SR-IOV is legacy and there's no need to support.

Yep, I talked to Parav, makes much more sense now for me as I now
understand the motivation. I was not able to reach there just by reading
the patchset :/


>
>
>
>
>> 
>> >There is interest in the community to include an interface to allow this
>> >in the virtio spec, when the PF is a virtio device.  This is what this
>> >patch does.
>> 
>> Yeah, but why? As I asked before, what are the usecases? The fact there
>> is interest in the community does not mean it makes sense to have it :)
>> 
>
>If people want to build such hardware it will need some interface.
>Far better to have it standard.
>
>
>But generally e.g. intel already said they will reuse this
>same structure with a different group type for SIOV support.
>I'll mention this in the cover letter.

Cool.


>
>> >
>> >
>> >
>> >
>> >> >
>> >> >For example, it might make sense to split creating/destroying
>> >> >SIOV devices from the transport passing data from the guest - the
>> >> >driver would then not negotiate VIRTIO_F_SR_IOV (which
>> >> >then means auto-provisioning).
>> >> >
>> >> >This is out of RFC, since we have two commands which are useful
>> >> >to discover supported group types (ATM can be none or SR-IOV).
>> >> >
>> >> >
>> >> >Michael S. Tsirkin (10):
>> >> >  virtio: document forward compatibility guarantees
>> >> >  admin: introduce device group and related concepts
>> >> >  admin: introduce group administration commands
>> >> >  admin: introduce virtio admin virtqueues
>> >> >  pci: add admin vq registers to virtio over pci
>> >> >  mmio: document ADMIN_VQ as reserved
>> >> >  ccw: document ADMIN_VQ as reserved
>> >> >  admin: command list discovery
>> >> >  admin: conformance clauses
>> >> >  ccw: document more reserved features
>> >> >
>> >> > admin.tex        | 540 +++++++++++++++++++++++++++++++++++++++++++++++
>> >> > content.tex      | 112 +++++++++-
>> >> > introduction.tex |   3 +
>> >> > 3 files changed, 653 insertions(+), 2 deletions(-)
>> >> > create mode 100644 admin.tex
>> >> >
>> >> >-- 
>> >> >MST
>> >> >
>> >> >
>> >> >This publicly archived list offers a means to provide input to the
>> >> >OASIS Virtual I/O Device (VIRTIO) TC.
>> >> >
>> >> >In order to verify user consent to the Feedback License terms and
>> >> >to minimize spam in the list archive, subscription is required
>> >> >before posting.
>> >> >
>> >> >Subscribe: virtio-comment-subscribe@lists.oasis-open.org
>> >> >Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
>> >> >List help: virtio-comment-help@lists.oasis-open.org
>> >> >List archive: https://lists.oasis-open.org/archives/virtio-comment/
>> >> >Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
>> >> >List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
>> >> >Committee: https://www.oasis-open.org/committees/virtio/
>> >> >Join OASIS: https://www.oasis-open.org/join/
>> >> >
>> >> 
>> >> This publicly archived list offers a means to provide input to the
>> >> OASIS Virtual I/O Device (VIRTIO) TC.
>> >> 
>> >> In order to verify user consent to the Feedback License terms and
>> >> to minimize spam in the list archive, subscription is required
>> >> before posting.
>> >> 
>> >> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
>> >> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
>> >> List help: virtio-comment-help@lists.oasis-open.org
>> >> List archive: https://lists.oasis-open.org/archives/virtio-comment/
>> >> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
>> >> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
>> >> Committee: https://www.oasis-open.org/committees/virtio/
>> >> Join OASIS: https://www.oasis-open.org/join/
>> >
>
>
>---------------------------------------------------------------------
>To unsubscribe from this mail list, you must leave the OASIS TC that 
>generates this mail.  Follow this link to all your TCs in OASIS at:
>https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

