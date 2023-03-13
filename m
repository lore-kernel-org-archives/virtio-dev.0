Return-Path: <virtio-dev-return-11611-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68AFDC6FD19
	for <virtio-dev@archiver.kernel.org>; Mon, 13 Mar 2023 10:05:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 204788470
	for <virtio-dev@archiver.kernel.org>; Mon, 13 Mar 2023 10:05:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1ACF79863BE
	for <virtio-dev@archiver.kernel.org>; Mon, 13 Mar 2023 10:05:34 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0F01B98636A; Mon, 13 Mar 2023 10:05:34 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E193A986312;
	Mon, 13 Mar 2023 10:04:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3JtEID9Ai7eL4cO4XrGETuJohaR9iCbVPxvUHBCdN12+/sIQh20RIwbTCBc25VdRIbf6+rYv8SczkMrzTeLeCXztgbnF3i5ivH807aKqEvwiuSIgaLrArSeNF768hkYQnY59ThYA8W1mS0XKJia58rnoK5dn/NenNHopuyEin/ujiKgrdlWSbK93cKYyFd9QA7rxwHiBbGb0hwZnv1d5B3cT1v9vobYPKw0jajfydwCG70IqADisouUTCTzwRy6VQrzKkCUE8MbwH9iUABYX3X5p1JFRYS81OIq/LahT7XlknUiTpk9wUZCjyfNL2bv9ni5k2saeWQ0NofxxhtPwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4i+Os123Fuq0YFQnX8mGX8UPiwDmEeTlJYRrCMBu+gM=;
 b=W9XDN+lMw2hDU2cHSrrbKlVY/aePc4wy+y6dQNOW7/Ah8Dp5QEVTMCtOdqpbrgUtRhZrft3fNCn43bfBV5E+JtsNH6BHwqjpvTndi7KHuQ5Ke/thtNGlMU1XuS2FYo1wuOpiP4+IdDjmjeTShelHuhO6IErXiOC8aW+eTTmv166rJuEDURcb+HcoUS0IlkF4ftyq2mFAJ+pVqpZKZ95PZq0zBPXCTdKbJVlaAdFI/tKWQY31PNrzR4tWWxKyZ7TNNwuf485zgTVoD7lCnibv9tAr5p+GHtzi4YMEUE9imb8Ew8Ud014vFaXgzmz+oFc4PCWig5b+apy6hP+rJvHr8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Date: Mon, 13 Mar 2023 11:04:48 +0100
From: Jiri Pirko <jiri@nvidia.com>
To: Parav Pandit <parav@nvidia.com>
Cc: mst@redhat.com, virtio-dev@lists.oasis-open.org, cohuck@redhat.com,
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
Message-ID: <ZA71QFjxiV8bDDSa@nanopsycho>
References: <20230310150519.115090-1-parav@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310150519.115090-1-parav@nvidia.com>
X-ClientProxiedBy: FRYP281CA0014.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::24)
 To MN0PR12MB5979.namprd12.prod.outlook.com (2603:10b6:208:37e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5979:EE_|LV2PR12MB5943:EE_
X-MS-Office365-Filtering-Correlation-Id: 835e6c05-2654-4919-9788-08db23aa6448
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jBstaqyXxi3mOKdfS5HSo4PW6ppB56hVX0n6TDG4z8mrvopqObKt6TSxh05GEN+6tbXtWEQvkbvw45LCsRFQsyNxhx7hct94+2bPcM4Wk9Db1OldnOUeJYp9hWnT7Rr6TQ43VlSsibaS2GFFuMOxWA/xtjQhaMBFIvnUcRFhcLOn6o3u8Abu3ejqdyctACyJOv5whLhoUyIP89fJQLU6p4psIvr4gx5I7oNSbwt4P3mLhhZR6LqVnV7/45WBPBm3ne2VaF7KqRwyk4Xy+xH9WiA+65W4znCo4V4d/1PgYEnLWJiEpeRYCojEG6fFImREE/6Rm3abpb1gCOBil25PUiZ4DBDanNP8mKpfyR2q1wz+AvPdcAnjITsmniSK04s8LU5q3GljiXKyY/zwe2pEY+sz2CCWk0HVLhDb15EzG1KtQYRuSlKsjulCC5Cc0YStZ9zwx1FmCAS7aYQc6CAGL+mWdTAzwn5NOOdk11GnAftoeKVR4OztHNCQfHV+WcTQD2AcH5KaADm/iFnW9+y8VDkgADSx2gvJ8zWj+JuC+QQ0t0QyfJglGkRSLBg31SIxeOwDtPIespe1fqjIciTwB9zx1rYuOs1qP2rr8F00OYXM8qA7k5MOUdk4JSWsOiOMAjMjzas24jFmrd9nMMtOBg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5979.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(396003)(366004)(39860400002)(376002)(346002)(136003)(451199018)(558084003)(86362001)(38100700002)(2906002)(41300700001)(8936002)(6862004)(5660300002)(33716001)(4326008)(9686003)(6512007)(6506007)(26005)(186003)(107886003)(316002)(6636002)(66946007)(66556008)(66476007)(8676002)(6486002)(6666004)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K+2Gi71QP6AqUvmtnuOQfNhRFxxJp2vq1JyibkPUUWoyyExvFb/1epJmUXXj?=
 =?us-ascii?Q?6CsGbjMYCLpvoFCq1sonYifJYLIY0qpDCJ0MQR7GihkwKyKngVRS4dwfeJxW?=
 =?us-ascii?Q?CjwDDfJ8CaUQLjAyyH08DImiccg8lspImR5fiVNPbltcILTOnDSlxjsmsmx7?=
 =?us-ascii?Q?sM+8IEiM1AgecEULOIRrP/ptImhrUzPkMDQj8dLp6P6/hI2Y+5RjDpfKsXjS?=
 =?us-ascii?Q?CM9l6r9DdkIG0pesk9yOt5jwrv3G3QJkJYKBmEF0yyGI5XP683GkTj4weguk?=
 =?us-ascii?Q?acI5zWODhfz+xo26LOlT2orWlZmVpfgLP2u3ZqfyWD0KnpfnXxlLXcE3PL3q?=
 =?us-ascii?Q?u/7btCHFwaNphHGdXR03JK23zq43BpqNe/vm2seH5vHL1sPQqBzFvspnHaOK?=
 =?us-ascii?Q?NmMMCtsLgWYW6AC4sckG76j5qceByMiixVSIrrSVnqWeRxQQJ5iffP0GBWIy?=
 =?us-ascii?Q?NXaGebsblFV4niuF1MPORQAvKzD/kgSPv4OLlnb8my7WFHMiLgwXIoL2rKsX?=
 =?us-ascii?Q?OrcndqSXDIe/SEci/vuaYJfCV7PWHl6AVElQy3RTGqIuNcdUije3Xo3lqfCV?=
 =?us-ascii?Q?ucIdOdaSzA1BbeKAHjOqsA/uicASKqhuYiXaA/Li23vDy3nm7HBM2y7Pu3Qh?=
 =?us-ascii?Q?vuoVccksjbUiCQtKn+vBFhX+U71M9C0JUf9P7bkdNpmSBw1TS6xVW/DUixFH?=
 =?us-ascii?Q?100g4XBaXEP9jnof5JFU8GW+PiWWWZKFtjq+ZZHkBbeIG7I4j1xIZVsa9Sin?=
 =?us-ascii?Q?NjgKd5d7rN/T1MXy7e/R9OLYs/wNeFOuGqzQpoudCb8Tm8IMe0hSkYfMe0cb?=
 =?us-ascii?Q?6sn8ZZZ3jUr+7igoUziT3XnYl1AYUHhgThkig05PmefV6gilPMi6KcyYrIvY?=
 =?us-ascii?Q?gFXwR9B0vB5jFXCE4qOBk9/1A0kE8mL/fjFdJ6gy1H+Jn06BhBa38lfq6LuF?=
 =?us-ascii?Q?R2Yxa1GF27pG7RTDXQgnxRHTj+y3ZaIC1vyXQ9SL/mi9x5PnXmv3BpJpyJNb?=
 =?us-ascii?Q?tH7sZEmpQToZAXYaRNuViZO2qWomEk5g39ggDMao4k4ljB7+TBHYr5YiS2Ok?=
 =?us-ascii?Q?uokHxtXa7kQflia5aiXmKqd68bnEseWowG8ZlI06sAU/JrnryvLwKqrvqee1?=
 =?us-ascii?Q?oA8rWPdgKmTRus8hlziMk2O6bP3mRtcBbrxdR1lPZ7l45cf/bngZMGwMasbr?=
 =?us-ascii?Q?mF7WOsXmq32AjVkXe0QGLC/tntqVXvEaM8Xc4fJGZT8pXJ5TNSNrYCeJu4C8?=
 =?us-ascii?Q?k9PjNGL/gvPcZz5py8NyFhSqw0mkQY40FNAe4GiwJNztRctf7k5waG5pXXql?=
 =?us-ascii?Q?G+z3l0fwoKXN+YXNstLFWRH5jBjhAbiAyNA8WneMN9p/augxxlLFEqzzNKFz?=
 =?us-ascii?Q?W9Us75XX51Qzo1eg6rQ4iSW529HDUz5IK+IHTr6VgdE6teg4Pv4IH1Oe9szZ?=
 =?us-ascii?Q?AxQxd9HN5oChGk4ddP26BuXRh/fyxapBE5E6n0cOL+/2zmZWG4NC5FXy7ker?=
 =?us-ascii?Q?ktw9Kh0pKrY24QT3Gyw0aDxeRZL6gflDnEnjK/RTkt1OvVgfCFyYDnV/DWlL?=
 =?us-ascii?Q?h+Fq+xw/gGMh4rU60L0xkq2FzgKhHu6/hw+iSmlq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 835e6c05-2654-4919-9788-08db23aa6448
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5979.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 10:04:53.8510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FhuD0Otqf9SVAbRoHqU7QGvqkLPxeoNXMupljFBKIO76/AgJdZA6/NL15Onr8kwy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5943
Subject: [virtio-dev] Re: [virtio-comment] [PATCH] virtio-net: Fix virtqueues spelling
 error

Fri, Mar 10, 2023 at 04:05:19PM CET, parav@nvidia.com wrote:
>Correct spelling from virtqueus to virtqueues.
>
>Signed-off-by: Parav Pandit <parav@nvidia.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

