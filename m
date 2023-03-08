Return-Path: <virtio-dev-return-11504-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B420C6FD1F
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 10:09:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id EF2DB6037E
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 10:09:07 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D6DDE986717
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 10:09:07 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id CBA099866FB; Wed,  8 Mar 2023 10:09:07 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B1E269866E7;
	Wed,  8 Mar 2023 10:09:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fky/8G18dQsuPUUCtGT15ghgJ9yePUfhUIC7kBVM0wsZIX8TRB+QzeWFAcgwb42Vf6IYI30wreltC4+PfSlR2QQbMHttCn2KWH7crz4tqZhCQVXI0vXW0h4Gq3Cetrpf6PzrBEB2Ya7F3v0O1yCFCCYrCXBlMYYrKRK9+skkLpsq82aj7pYMNJuTtOjnOwt535+VaOoubBmd/kqxXb7W8GQmJvTr0RPP9ghVCKNS6cj03ukwanwsAcIvK9y3n2el9HCVqCaDa9mqVR85z/Z6D5/Y8qAYwSNtDeifgxKK0ZKDRqgo8g0yBSLLE2zMU73n1dDrUu5K4eULqMSsm4CU2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDlhFql1Uguaz8Pq18EPump6ZAM9lzZFapBopBYtzR8=;
 b=BKed7oRAuxnSPa6eG0X1d8DcsZuEy1QiZBeuiWIE9bEV5fa2fVvNI6WpRL4U5nD+W+ZoHrsmYyqOKOfz3FAF8l/758eGlbVPUDpKbIuHd8g2Wf2/H2QeY9lvvoh7DNig9L8FnyG3TRRL/C07GpvhoQYPM5CazVEF+0Wbh75uvcdVMNvSHI+X2nrZOpKBjj8B+mpjuXRbNWCk9w3eqAJbi7ggeAJJU/D7v857DC0sw+ur3j8e2wv2L7JgpD54HHS5SV9Q5yKWSkZpxPVi9hqr0dqFpS8manF2Ck+zjpg+W00tZa6IS7AvgBaBqseZ7H+a0t9ojzMc5Dcps/wao3EgbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Date: Wed, 8 Mar 2023 11:08:56 +0100
From: Jiri Pirko <jiri@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org, jasowang@redhat.com,
	cohuck@redhat.com, sgarzare@redhat.com, nrupal.jani@intel.com,
	Piotr.Uminski@intel.com, hang.yuan@intel.com,
	virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>,
	pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <ZAheuCy48ZUObdzQ@nanopsycho>
References: <20230303132840.GC2866370@fedora>
 <20230303083213-mutt-send-email-mst@kernel.org>
 <20230303202133.GA2901137@fedora>
 <20230305043419-mutt-send-email-mst@kernel.org>
 <20230306000302.GA244754@fedora>
 <20230305191351-mutt-send-email-mst@kernel.org>
 <20230306110340.GA35392@fedora>
 <20230306133525-mutt-send-email-mst@kernel.org>
 <ZAbvxj+7lgaI1HkI@nanopsycho>
 <20230307111143-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307111143-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: FR0P281CA0096.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::9) To MN0PR12MB5979.namprd12.prod.outlook.com
 (2603:10b6:208:37e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5979:EE_|DS0PR12MB7928:EE_
X-MS-Office365-Filtering-Correlation-Id: d52d549b-a353-41f0-86f5-08db1fbd2377
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mrcIy2xp1Ttwb+rBKfSByGC53IMeS8ttvFXu2PD+J13+1U10IUOHbSBWcNk+I2uQBdhwk1Ed5b7oUULYoI923yjAWR2UlFGtrkZwmxrrqrGpDUcNSEwx+hNo7efYSs67RXRQc6o1u/KgzusJyHHn3O/Qi9Jf+Rkmeu5F5K0m6669szbWbi+HhLFlaUbgPTAZPNUtvUkdP6TbRqE+pPo3F5ipx7XTjIDG2Auv4vA7QLmqIW0wYbTdNz1fgw6+Qvl/h1uOcR3IxstIonfmcOYlxgdxs2vrYKVk7Q66ZROTR4367oqB2gDnCLxjY7c84muisqycMhUF3YcXFbMOlZOPqstCRstWCU+wWYLXm+Ki/QR4v8R4YORuVdzG6vZfwc5I+RlWquk4+WXT24UrBfk7wmWwSle/2xwvJgM1ki1NOKh2vOCSwMo7OipsToCGEhmZh8PilVTJpQTY+rn9U5Cada81CuKKFVq7Mu0kQ1SY+xatS6erhAn3F1MU4Ee9HQazQiKBBtGCsvXzW92senrFU4DULXaTA6MbPdr2lqgBJj65/IKC8GBPUZX/9nkAuw2t6k+7aKUz8hRvyZ637TZKUw4LtVEJFPkx3c2nTSVYAjGz0UBkImN9/E3OYAgXPVSooRYdZQmDoFkOeiFVC9+cmv69rS7bh/D4vVyHoy+f9r5E9Xd6eGTSw1hc4yYGqRhAOfR5B7Y1ILF70Zb6km1D1g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5979.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(4636009)(376002)(346002)(39860400002)(136003)(366004)(396003)(451199018)(478600001)(9686003)(7416002)(26005)(83380400001)(186003)(107886003)(6666004)(6506007)(86362001)(6512007)(2906002)(966005)(6486002)(5660300002)(38100700002)(6916009)(41300700001)(4326008)(66476007)(66946007)(8676002)(66556008)(316002)(33716001)(66899018)(54906003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XoyDYMIRXb1x0KQwvHzI11ZJV3XCwg7vK+6QaNNaXbeCvAsTUduPuWUG7KQf?=
 =?us-ascii?Q?kv0SyjvKvwrYs51z773RuneZIIobf5l3b4Sn4TWcx7iMJalIxYzlWCJlj77y?=
 =?us-ascii?Q?6vyspVEXFwZXHrJG/4cek36FlBGLWWmPy0PupBBV0aIpRrZL9YsNcEmpSxvx?=
 =?us-ascii?Q?iqf1UA4af3vHpOwb7icc/mfBWKNpu/vegtubMLwIlA91ZmrAMfcyenxJ+FTT?=
 =?us-ascii?Q?6v8mobgZPgAsAPqwMgaSyjhRIQegpyhYD2PXcB8WEi2VmdFFtOaznVVKU2R7?=
 =?us-ascii?Q?8mxLe6WQCIKSLhwzZqESHWffbvulK8ZFolvI6DiUbugqA3FOe/Av7R4MpvS8?=
 =?us-ascii?Q?CTSWtRXguXzqG51yAoboKxdMZi6a25sYxXYJ2Gvmq1Gi7VbcHvEVzWI+VyEU?=
 =?us-ascii?Q?Qwc3B6JouuKpuBT2FyqavMvclI+O84MvzvqYD5t7l++HqMstmmxhpx4iNwNI?=
 =?us-ascii?Q?x3ccBjXYQKYv92h5yD5soF5NeuL1hQgA6EFfnZJ9l4CgQQEmdg9jwaBJwezZ?=
 =?us-ascii?Q?wJ/RENK6311gCgK1HOV84y5mz+I6qOPe9A/XaVVXN88V3wczFy/SfoOHrKTG?=
 =?us-ascii?Q?OezSs2kN5GygzhklhTe4aKe2gcAltLrhUFBANjcusKYmmpqD66P+Sl2d/wej?=
 =?us-ascii?Q?OpjK/u1KWPuRQcRRGdDNkaNnhF57oJZMX2BfXOgDoaqIWGRg1qHus1Pvh5dF?=
 =?us-ascii?Q?iS5jmtEIJVZ4SRVARcSCvoq6ao4PFpekIhG/pulIy3zQl5CMaf970V2rKl4h?=
 =?us-ascii?Q?ckO0G0kZrmCUakCV6RRT1dMkwaXTDqLrudGhtqxEXA6yvipNTL95kRu0kLAQ?=
 =?us-ascii?Q?hHOoF6yqXwcy3JCvsFqipsDOOxRZMV41ZL8VfhBvZ1X4qoh6hfdCWjtLPUZY?=
 =?us-ascii?Q?LtBrbdlQnFysGS2ex55PULy52SFvYi4IOeR0BjFOqFSGMidEshHqq+e9JHFA?=
 =?us-ascii?Q?rbhkIWrT/sKOw68yEs8Ud4Q1+LCsDvdnoHdv27sDN4UC535ESD6TsxHx11oj?=
 =?us-ascii?Q?tv6CEUj0XMLKIma/OX+29pvyvDC8Wsv7gE5+9HT4fZApMe9PiJPxySjkijgz?=
 =?us-ascii?Q?cR2E9jIXGRxIuayRmudwYDJLu9/U5dyEFN/faip8C9egHsb145DF/9EhhVrb?=
 =?us-ascii?Q?ItkZz8oe/CWlkYJVdn36lNbqUE0X8c8ICJT9W4AZO4UA1pkemVgROOX5hoYP?=
 =?us-ascii?Q?zUWZaelfTTto+gE+v90XHa4oAOdCgltP5WkjWAB7/PeN7xToAPMCYRr0UdFe?=
 =?us-ascii?Q?xY+h6fcRSW571ApYAjkYIcAOaSruqvSzfpahfehzxNP0YPebGMvg2Ko45FTE?=
 =?us-ascii?Q?1Z593b5imRegI1OA6BMWKqjIc8pbxLVrbCTooOtMffnqABweVTkbMe1q6YLY?=
 =?us-ascii?Q?RzQKxTzdElx3FqNItNU6CFsTWii60QYkJ+eTeATsudLGXwrGO/x5fReBoekw?=
 =?us-ascii?Q?Zf+oE0t3AOY2Y+V5y/AzZPEs5yepHAdsse+UbUdGF5YBbTNfF+Rx/640P1YW?=
 =?us-ascii?Q?oNef2IBRvQzE/rTCRbJJlaoivcwXijT1i9ZEexHUtSJ7lXCNN6bnmNievCOO?=
 =?us-ascii?Q?zHlooUovaP+BB5Pk8W5rcFQRB5n/5NRc1Qfxd+Bw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d52d549b-a353-41f0-86f5-08db1fbd2377
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5979.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 10:09:00.8622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zgvJ9f50QNYgushc5fmHFfx12CzGO5jipYMfyTe5zj16Xg8oC4zZDT/YVQSgGL/o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7928
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio] Re: [PATCH v10 04/10] admin:
 introduce virtio admin virtqueues

Tue, Mar 07, 2023 at 05:13:01PM CET, mst@redhat.com wrote:
>On Tue, Mar 07, 2023 at 09:03:18AM +0100, Jiri Pirko wrote:
>> I sense there is no concete idea about what the "admin virtqueue" should
>> serve for exactly.
>
>Because the virtqueue is just a virtqueue - a way to pass around
>commands.  Admin commands are used whenever one needs to talk to one
>device about another one.

Yeah, I got that now. Please check my other reply in this thread
suggesting a name change of "admin". Perhaps it would make sense and
makes thing a bit clearer for slower people like myself :)


>-- 
>MST
>
>
>This publicly archived list offers a means to provide input to the
>OASIS Virtual I/O Device (VIRTIO) TC.
>
>In order to verify user consent to the Feedback License terms and
>to minimize spam in the list archive, subscription is required
>before posting.
>
>Subscribe: virtio-comment-subscribe@lists.oasis-open.org
>Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
>List help: virtio-comment-help@lists.oasis-open.org
>List archive: https://lists.oasis-open.org/archives/virtio-comment/
>Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
>List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
>Committee: https://www.oasis-open.org/committees/virtio/
>Join OASIS: https://www.oasis-open.org/join/
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

