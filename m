Return-Path: <virtio-dev-return-11610-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0473C6FD19
	for <virtio-dev@archiver.kernel.org>; Mon, 13 Mar 2023 10:05:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id BD4971EDF8
	for <virtio-dev@archiver.kernel.org>; Mon, 13 Mar 2023 10:05:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B7D4A986373
	for <virtio-dev@archiver.kernel.org>; Mon, 13 Mar 2023 10:05:30 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id AB19A98632B; Mon, 13 Mar 2023 10:05:30 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8AFCB986348;
	Mon, 13 Mar 2023 10:05:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dNwL4RlYJ+fYA8U4py9I8WOOMF1eTEd84z7ptW6mrCvXkpvlDGuZ2VHFUB5LWUuRlsHQJQquxFcrUJq+zcvLqM/W/aAFlTufHMgtuuyXlsimG5DGxvzKpPUR82bVN28DczzaXY6zJ/EZsG/Hyd8cWQ/G6/zU8gK57Cn5HcCvCbs1fM/gSSF0i3PDG6BTc+cFmMTPC2eG/iGd8S1NEyIe5jV+tnvuaMzZACDfcQWIu/pbtuP8/ty6QBG8BslTzjNFbuVGwxUmGUmHRH7sR82s4kUZ7Hezh5K/7Xs3tKKwmYX49tVNNqzCdMHsj9O6Fftt0uw1PsejPeCGDvb45B2kGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=92jRc8fX6bbcvwW3x2RQQbQCGgnEpMUghSDDSGi2ovY=;
 b=jFqgdhkDxSEleSYicb3tA72vIPQpmksmiLdunFo90447ZPraxj1NaSxAbIOz2YrLeEU0s5w51/SufKaVsrfhzOYIdb8sgbzQGKQwoFK7Ji4zZ8hyjj/5zbet62aaixWJfV7a0PlFGnk/9P+SyHHlr1gpgosa/jXdHRjJxJAS5YZeXL/h2XWOY2Bncw+Xnc5m6r9U2cWK3qlW/0t5UprGaA3isapqFj5E9SSzU63e1tv6jUpegLQx2WmE4s18DGgmVQ0dn2YvHrTe9A8tOF4mLsRfhnFHsMYwgF4hZCHg3gOaiZwXwiovVFKqIehXlIpK7OrN+j4P2frjluBFqnVSyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Date: Mon, 13 Mar 2023 11:04:55 +0100
From: Jiri Pirko <jiri@nvidia.com>
To: Parav Pandit <parav@nvidia.com>
Cc: mst@redhat.com, virtio-dev@lists.oasis-open.org, cohuck@redhat.com,
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
Message-ID: <ZA71R5tWLaTuy/jV@nanopsycho>
References: <20230310150620.115188-1-parav@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310150620.115188-1-parav@nvidia.com>
X-ClientProxiedBy: FR0P281CA0109.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::9) To MN0PR12MB5979.namprd12.prod.outlook.com
 (2603:10b6:208:37e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5979:EE_|LV2PR12MB5943:EE_
X-MS-Office365-Filtering-Correlation-Id: 87afb4ae-0530-4487-2a22-08db23aa678b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	W2c73+hFlVMb5kdeYCz5GvCCvIyR/fBBO9fWDAHyn+Z6X+6YtKsKQ285lOwHGuK3tBNBbak5DnspnrflnE0WBabmpZvhuyc++xST3kTd5KaYoqdJgALGeuWghsp5+qgJpkvCYcgjm6WBHKqfwWy+9B0Uj2et9jmcSstKCE5bAGSnqcboP6Gc4Nhg+mFUIYLZFdtqMUE9U465hdTvtdATA9oxlJFfvbU8yKyb9ZjZ0V6OMRPc57yIld2uSnUrjK8TUhitMonrE2ZMV7mPfd56fE5Jp6/yWQqnQ0H79rQ7wbpPRhV1wi8piWhDnbdM7pHX3fm42Xj51p2Xlh0ezKQU4MooRvcvi63azOZCfBf8LiKgPyt5X4kEC0rl9+Z0T+OB6RyaqU2Ut3qTzfvNoimzDW8pH51urPArQRVWdQFnZ/j6mwVqchd8Ml1gfUCKEZMlpEQe7dkjcdGjU31qzMSWFRPb9iIgdgfg7kNS8UA5DWXHylYvy9hTYQYBvPuiIXfCo8KahA7t/AjU/Yci9mLfGleSnl2SMve/yqRjsjcViOTwFZslmxKuPjsaBmDA4829VudWgfNBenLlaYGvchv9NGmEoiQqexxzv5uqNf1+2BJ9TSM44NKy/yaaZZdaqQMh407G1wr1f7E9hJ773LZ1HA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5979.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(396003)(366004)(39860400002)(376002)(346002)(136003)(451199018)(558084003)(86362001)(38100700002)(2906002)(41300700001)(8936002)(6862004)(5660300002)(33716001)(4326008)(9686003)(6512007)(6506007)(26005)(186003)(107886003)(316002)(6636002)(66946007)(66556008)(66476007)(8676002)(6486002)(6666004)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Wn0GIxR+gSuqdgtuGYGEdPsw/7cfSGGfONKlQ9T6YFCsanZUhhzrngnQxGT9?=
 =?us-ascii?Q?FW/qqwnnXCnxRA1vuL0s4DgyrDT7zK5zu2KMCxV/W9RzcVjesKEaKvLwyx9t?=
 =?us-ascii?Q?IvbWcgR0pkgaS5z7TUazyWwat3yZrs7pmpqbaezpuIkMo1DUKVx6xBb00xlw?=
 =?us-ascii?Q?N3qQ2khlsfc0CBZ2gE1gtwW5cy5ickZ7vfYZAMcEhYXns3qld8knfdrrjxeB?=
 =?us-ascii?Q?BItODhUw2ph9oXcrAy7CTQ/pJFa55Rj6RC6PWRLPEmCDsdRkSE3tFK5i5985?=
 =?us-ascii?Q?MHXcLJPaDGN0S9x/WH0FdAUuFmNRhIRQOkr5gfz3viZOtouczP4NMstv8uGP?=
 =?us-ascii?Q?mDqrmBPvq9JWp+EJKKbE7ukHUmAlFDNSiOY/NaFxIGDqg8UcMMc5rwoE0zNM?=
 =?us-ascii?Q?woYnMmZvgIE7ElD7UmE4GMjB5z0mAJyqvNXr0p0gZY4B7xM4hqQSRcMYkB5m?=
 =?us-ascii?Q?qEj5YmM868COifOVdgmdyXPP/W55fx3ymGbe+96y1vY38O5zVS4ydATix2/1?=
 =?us-ascii?Q?zCRqzWwNSiAQoMYWnn7jXpkSTEQ/SnoB7Bnn7vKWws4Cf3thq1DBsYL03Js7?=
 =?us-ascii?Q?RXEODdHTm4qaRou+PFQmJ9bieqdwNjAhZVj05YS5lYtrC/F0cyAPk8trX1py?=
 =?us-ascii?Q?tJxWhqZmSdYGM9Btx7XRiOYVIT16rKgWF0ngFXTUP1U5EJLISRQE7Ma/AHYi?=
 =?us-ascii?Q?UgB6rhafsgq4uDDLYPVah8A4SAEcDKzm1ZHz+1PWjvWgOelwRIfvU3ybhgoj?=
 =?us-ascii?Q?hMb/p7aocyAFT3ChayqU4HIKzY9VBcx3tKYexLFgQJOQ6rsUGX/s3ILo1YWn?=
 =?us-ascii?Q?rNQfZHyAakZYD+6Qy8cy7TFJKhT3hXJJz8cfNil6mBzjgQggFJDTc2l+mOrE?=
 =?us-ascii?Q?ek199Gd233BdgEv81/Z4rWCxApvI/Pwjt4wyIh//azhJtz1M7HlnIuxqEKcf?=
 =?us-ascii?Q?rDGDNG57qBXm3lYtaOYKgwDG4pfYbiiprZ3IptwAkjGAqRqFnfuPOEWP40sF?=
 =?us-ascii?Q?3PaHBgKXZ2Uw155xd15x0nMhJ1F+NEvxGOjSSY8HzxjrtHI29MX8Biy4dKGe?=
 =?us-ascii?Q?dNShLiP1e2++Zex+WQuqDA8N4g/YbeGU1TThzOXREcXtmlQL1W3m8WgtnCdm?=
 =?us-ascii?Q?rd2FAmNwPt6TSPB+JeLl2DRD02+3lR66G4szMdCN54gCZMGAGtYv+fD3qX2O?=
 =?us-ascii?Q?l15dAcUwBnQ+rnCYV6ENhFmaki1CrJ35ALfSwR2LDvctphzS5LWUim0ZKi1N?=
 =?us-ascii?Q?oWdUaAaH1XPU25RAgJVVojSXo3WJvWwTUuqCnvWV35/P/yyKiXEvSrYPLyXf?=
 =?us-ascii?Q?B/aUuMoXACu/ea5X88Ula4JuNfI+f9VQp3jh5pIOndTzrzgIpOYP7GhkWWpa?=
 =?us-ascii?Q?sNSRfrA0S/vv31xj/x1xInoz1wMcvs7aOhXT8bxpJrBSI+HzdG5Iku5asu0N?=
 =?us-ascii?Q?He52AEpy1BeEgmrxb83vCk8v37jiYec3ROeSGYWkDnBmqxgr8LnQ/1NwU52k?=
 =?us-ascii?Q?HrnZHiX5JNzAPny33RE2jSNu5qlDuntM0DoignCYjqV3wbtzs/Z86TlfEoAh?=
 =?us-ascii?Q?wju6BOqFhGj65zEiatFoYbSfIiJ5R3mWO7IZNtpQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87afb4ae-0530-4487-2a22-08db23aa678b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5979.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 10:04:59.2748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: syyYhnoYU4fj6gJak1uVtuNHImgLfNjQLjNSFA3Sxz4ibvmXujz0AtS/PozC4u73
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5943
Subject: [virtio-dev] Re: [virtio-comment] [PATCH] transport-pci: Remove duplicate word
 structure

Fri, Mar 10, 2023 at 04:06:20PM CET, parav@nvidia.com wrote:
>Remove duplicate word structure.
>
>Signed-off-by: Parav Pandit <parav@nvidia.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

