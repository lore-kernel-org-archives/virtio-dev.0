Return-Path: <virtio-dev-return-11561-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD45BC64EC4
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 07:37:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2E93A23D6C
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 07:37:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1D9C39867B5
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 07:37:26 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 118F89867AB; Thu,  9 Mar 2023 07:37:26 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F05B09866F3;
	Thu,  9 Mar 2023 07:37:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LVJ4VQKbUwgbnJ6qrBb9j20zdqsY1pq7yyDnMsihJMZwnHCR7SGDbHUoelY+CWHKyd2AUGBD8KoicnKbSAv4fZ9lJPD0pQvSXZnYaWaL1k27sz6DnavJwryCfJx/0tyFCr/gWZwZeV2zWF3wI03W/qegTwginICrP8H9qW9/ZeD7BhCJ6n8Ta3it3s4sq+uwQCi/ZEPi3/wTqZKI+yed8mR4NaGrI+fEqm/Ct5FbEfWkEkeOUfOLpYDn3yb7LBzcqNof/wiU2R/qF74yiRb2Q5k/4bN8zy95pcZ2ewo/C4zsbKu6vPDzGNadiqnL4xjTjIerX4BQ1uppyuZ6KGONdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0r0z0DbSwmmrvnJlXiSyGSVXGd577/Ra0I5C7ymxM70=;
 b=WocyR0UpKdnFVWa/WpfBp6/p0OIRwlSTxdV0qrXyBqmNGb5682IBF+9e+7JchmG380eY0imlpQ/un+qEnHPtfVjEekXgcg9w8MVn6ALHif8vXdms2Dw5Cu05xQgV6rGBk70kT7C9j0x9D7k0jr2AJh3HmydnYiBjPq3xhDpPN8uskXh3eqIOoWR1dkD96/tuVMcf07TISeHLojbjITsUvvznRnTaAEiIC0RT0jFmsk1QDd3zKne4UPo32e11xcw+5rToYsUwD6DqyA3IPGHfVFiMkrqiKVpcuzCdmSYa9ifz/Naq76W7tQXG9c6G3wCaXJt/JW5yC8xLFT0iMC71Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Date: Thu, 9 Mar 2023 08:37:11 +0100
From: Jiri Pirko <jiri@nvidia.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"nrupal.jani@intel.com" <nrupal.jani@intel.com>,
	"Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>,
	"hang.yuan@intel.com" <hang.yuan@intel.com>,
	"virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>,
	Zhu Lingshan <lingshan.zhu@intel.com>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>,
	Shahaf Shuler <shahafs@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <ZAmMp3W4CwL9xpD2@nanopsycho>
References: <cover.1677761896.git.mst@redhat.com>
 <20c81b66f0b21b5bd646c24840ac3f8462c86acf.1677761896.git.mst@redhat.com>
 <ZAXfegxCfvfLwiJT@nanopsycho>
 <20230306133816-mutt-send-email-mst@kernel.org>
 <ZAbpiRVdo8BciELX@nanopsycho>
 <20230307111458-mutt-send-email-mst@kernel.org>
 <ZAhdzCd6qwWydesz@nanopsycho>
 <PH0PR12MB5481E320D33B4594F050B3C8DCB49@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR12MB5481E320D33B4594F050B3C8DCB49@PH0PR12MB5481.namprd12.prod.outlook.com>
X-ClientProxiedBy: FR3P281CA0095.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::7) To MN0PR12MB5979.namprd12.prod.outlook.com
 (2603:10b6:208:37e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5979:EE_|MN0PR12MB5785:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f28e4a6-ab94-49ee-659d-08db20711b04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LYK7E5Rl0uMS5hDJd10fy8s1IofY6xNE6Jh6vxbEz5CuSJ7dAWTuAxxF8vapz8BtviLNqvsu/03asuIDcRf5OGHR6OR63pR0pEEe8DCOfULe60H8Zxo7/MBIXREYPALuHupUgmmEBlhjC66f9Zc3XDlJQVj+x6dCtzagfPJOm2DI5dfvvDv23OQOBHD6Rwk4681iNqyDuxm6noCdQqILK22NexHrXfhccwkb60ZgVGI7LcvlPaDadqFP4petC4uMXsqYubinLlRbrAnWmXEdiOP5HHoLwPKaWj1G+IDuWw8tROxDeuPTcccDqIMFzGgYLEfkCQNPsSEtT0SqxfrBQOeaHGRYmxddSSHg3fpzuVpf6REqaQfeEwStiuK8KtHJ6Im3AAdVJLfLXsWL7m2GqGTcWKfa3fID8768Y/7WlnngzqAWHWRSrlZNjP7Eo4XI9v/TwSXeBVJ8DrwCm+x4GgOv25ck3ZAkm02CJPGFlPnZJGGru9gCYNrUqXqw4rYasT30gLRuMixwzXyrzxJ6xoZTXEZuty7MgHF6tFM72Zo4BKLPY6ax7jV2JEDhKl54YN5lQScALzOBpv1C0M5xB9pDcdsNynb1BHC8wib0gXTkSAbeky3yNpPkJqq4ujjCvTuVXww8CXoJFWxxyPtD2g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5979.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(346002)(39860400002)(396003)(366004)(376002)(136003)(451199018)(6486002)(186003)(478600001)(6636002)(54906003)(38100700002)(316002)(86362001)(33716001)(26005)(6506007)(6512007)(83380400001)(9686003)(41300700001)(6666004)(107886003)(5660300002)(7416002)(66946007)(66556008)(8936002)(2906002)(66476007)(6862004)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jtH/qNY09D3fHwre6prp53PyLVetqBU7K08XIKXFGDqidb04P7LIVNZZcASV?=
 =?us-ascii?Q?ClzxGpTOeJdWDFvLXb2jadHT1TX8YWJBNoHwyG11Vm/PreXQiYOBw/lakhsB?=
 =?us-ascii?Q?bLw4v9isyUrVoUNhPwbLb1IL8BspAf4Bogbdd2M2euB1GCpNwArj/gTpNNBR?=
 =?us-ascii?Q?S1HR9CZn4lSi2NLiLOOs3bO+TVfRaiEF1TeWP5gnOD3OVwhzejHMCRJovxeD?=
 =?us-ascii?Q?JANWnTUySmv+JXpW6C8LKL/ROi32JsU31wRnDXILIiE7y42yu9E5LLag2yCI?=
 =?us-ascii?Q?QUpw8EQ6gJkpB9kqbJRw/RFOHIOADiOfwpZmJugBAPA17uuJ9RSWoMIueTuB?=
 =?us-ascii?Q?O9XHZbiUVh/V+vnqh9TYV0f8nKRb5lw0xLtEl4SwXnO4/6aRE67KHRtMYbVY?=
 =?us-ascii?Q?V4WDo3CRs9J+hWNCH8H7cyw2zmEAZI0WTJQtBWfKriCGPifZR9d6alh8lA2i?=
 =?us-ascii?Q?yBif2SMlizyY+MiLqQSrFR5cQXbn1DME8Jxc1266piGkjKk/ByVU7N+x8e9E?=
 =?us-ascii?Q?BcJUGI+1HShCuB9XrVnyE1RTIQgOn0WyfirZ1njDGv8VrAIu2tFRhuUR/o1j?=
 =?us-ascii?Q?WfuknJIv5tnQxv9s+G46pWp8NBqv6WOp+I1biYsgZeTz2U/sOqodNgt35aQD?=
 =?us-ascii?Q?021pn4cqizFLhoq3I44wdkQe50T7GLUh8X9xNk7IPv2yJlXMEdch8khZ65KN?=
 =?us-ascii?Q?ubrYJHjun5KWPj9QzMsEFJtoUG31khLw/lfRiTRtTiIqGVzQBywleVDN/Nzj?=
 =?us-ascii?Q?ubKbTa25766F18SkaD5OTRc+L/R+YgdPbH2/RyJyhcQaCjv2/JMAS9OSe8Nm?=
 =?us-ascii?Q?hfldDgIxJlIyNtyVYQYLWQi/JYzg3IN1+ZO9UADtttw/H49NwFaWNS0Z0BWa?=
 =?us-ascii?Q?GVoC21N2YDmpMmXQ46fxa3fxEoXlfCzLUhyguoQkEg6mEGOznmwf5P3pYRiN?=
 =?us-ascii?Q?jJqeNP9pNHtRTSiiaHqum6MPPS+a3Wit9uqLsBdz1+4tkUhF8kYqmlPpEiro?=
 =?us-ascii?Q?5aYUAfXnA67H3Lv4wmAFAYZSRlOSehFLWisn1aovFmnEjjfosAP0JegEUmiV?=
 =?us-ascii?Q?dQi2d6wdF5c56YuZuHbBzVQ/UcgetYOBwUIx+dt82+34zsU9Go4eoOxk5k8I?=
 =?us-ascii?Q?liDQScd3sqJdkm0cMy1Pfw2biGDYovZJlLatjb3GiyzDB+KU9HLewEOqgU0l?=
 =?us-ascii?Q?KzePSYThIQF0l9b2Z5IwCkqyA3IWyRVn5bBOUWzkFPg2MYyz8ggqcye+6Kao?=
 =?us-ascii?Q?FNmIn7Zp4K/iE3TuDf4qPY3KKb/nw5LxBXq9ozgOjWcS76UafVHaX3X/faSg?=
 =?us-ascii?Q?/WuxFK7KWPnA/pQvwoaWHg1PkhnUs1/Uqr4jwN5oMO1/wfaZtT/Pc82D1DVB?=
 =?us-ascii?Q?qomD3hJv0UXxTzDcZ20svlxz/22KL/Q2AC+iuPLcSH4XKHK8Ls3IaHZrGqTv?=
 =?us-ascii?Q?ZvLp/4k6p1bVhXBvbZZRlXHCq47hsBkx5RIQPwRlMV52g19fwj6OwOIGKSwP?=
 =?us-ascii?Q?5JeV2DpcE2nV5eWQbtzT1F+SJ2Pug2/HscXzSA4bmZnfB1YvuZZNIQs6ol2m?=
 =?us-ascii?Q?Rvbib3+4isR7JL16HR0IvWiGb86K8UqAMCSPhzsa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f28e4a6-ab94-49ee-659d-08db20711b04
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5979.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 07:37:16.1129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M9jg6Oj5KjJpKOcNAx9i6aQLBm+0LKIYyBr/djUjtishOIKeQoyMlxZ6zt0h1VTy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5785
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio] [PATCH v10 04/10] admin: introduce
 virtio admin virtqueues

Wed, Mar 08, 2023 at 10:45:18PM CET, parav@nvidia.com wrote:
>
>> From: Jiri Pirko <jiri@nvidia.com>
>> Sent: Wednesday, March 8, 2023 5:05 AM
>
>> >For example a common feature is to program a vlan and have device put a
>> >given VF inside this vlan.
>> 
>> I don't follow entirely. The way how the VF is connected to network should be
>> ouf of the scope of this interface. The eswitch manager should take care. What
>> you say sounds awfully like the "ip vf" legacy interface, which should not be
>> considered here I believe.
>> 
>> If PF would be the eswitch manager, there are other means to do network
>> programming, using eswitch port representors. But I don't think this is the can
>> of worms we want to open now. I don't think we have a usecase for it currently.
>> Am I wrong Parav?
>> 
>> 
>We want the ability to program/provision the virtio feature bits and virtio config space parameters of the VF through PF.
>These are host-facing parameters that usually migrate from one to another host when a VF migrates.

Here is where we lack to have separate "devlink function" entity,
independend of "devlink port" :/ I mean, for MAC config and irq vectors.
What other host facing parmeters you have in mind. VLAN of "ip vf" is
definitelly one of them, I have to emphasize.


>
>A future device may even do this out of band, but we are far from it.
>At that point in the future virtio management device can take birth and do things over it.
>
>ip vf was legacy interface and it is not applicable here.

Agreed, unacceptable to implement "ip vf" legacy interfaces in
virtio_net from my perspective.


>virtio net doesn't implement it either and I don't see any user asking for it either.
>All users have migrated to using tc mechanism for long time now.

Okay, so the bottom line is, we should take care of host facing config
of VF, but we should not care about network plug of VF - that stays out
of the scope.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

